// ============================================
// SUPABASE EDGE FUNCTIONS
// ============================================

// ====================
// 1. AI Content Generation Function
// File: supabase/functions/ai-content-generator/index.ts
// ====================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { OpenAI } from 'https://esm.sh/openai@4'

const supabase = createClient(
  Deno.env.get('SUPABASE_URL') ?? '',
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
)

const openai = new OpenAI({
  apiKey: Deno.env.get('OPENAI_API_KEY') ?? '',
})

serve(async (req) => {
  try {
    const { 
      organization_id,
      event_id,
      content_type,
      platform,
      prompt,
      agent_id,
      user_id 
    } = await req.json()

    // Get AI agent configuration
    const { data: agent } = await supabase
      .from('ai_agents')
      .select('*')
      .eq('id', agent_id)
      .single()

    if (!agent) {
      return new Response(JSON.stringify({ error: 'AI agent not found' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    // Generate content based on type and platform
    const systemPrompt = buildSystemPrompt(content_type, platform, agent.system_prompt)
    
    const completion = await openai.chat.completions.create({
      model: agent.model_name || 'gpt-4',
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: prompt }
      ],
      temperature: agent.configuration?.temperature || 0.7,
      max_tokens: agent.configuration?.max_tokens || 1000
    })

    const generatedContent = completion.choices[0].message.content

    // Save generated content to database
    const { data: contentRecord, error } = await supabase
      .from('ai_generated_content')
      .insert({
        organization_id,
        event_id,
        agent_id,
        content_type,
        platform,
        prompt,
        generated_content: generatedContent,
        metadata: extractMetadata(generatedContent, content_type)
      })
      .select()
      .single()

    if (error) throw error

    return new Response(JSON.stringify({
      success: true,
      content_id: contentRecord.id,
      generated_content: generatedContent,
      metadata: contentRecord.metadata,
      tokens_used: completion.usage?.total_tokens || 0
    }), {
      headers: { 'Content-Type': 'application/json' }
    })

  } catch (error) {
    console.error('AI content generation error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
})

function buildSystemPrompt(contentType: string, platform: string, basePrompt: string): string {
  const platformGuidelines = {
    instagram: 'Keep it visual, use emojis, hashtags, and engaging captions under 150 words.',
    facebook: 'Write conversational posts that encourage engagement, 40-80 words.',
    twitter: 'Create concise, witty content under 280 characters with relevant hashtags.',
    linkedin: 'Professional tone, industry insights, 50-100 words.',
    tiktok: 'Fun, trendy, and engaging content that appeals to younger audiences.',
    email: 'Clear subject line, personalized content, strong call-to-action.'
  }

  const contentTypeGuidelines = {
    social_post: 'Create engaging social media content that drives interaction.',
    ad_copy: 'Write compelling advertising copy that converts readers to customers.',
    email_subject: 'Create attention-grabbing email subject lines.',
    event_description: 'Write detailed, exciting event descriptions.',
    press_release: 'Create professional press release content.'
  }

  return `${basePrompt}

Content Type: ${contentType}
Platform: ${platform}

Platform Guidelines: ${platformGuidelines[platform] || 'Follow general best practices for the platform.'}
Content Guidelines: ${contentTypeGuidelines[contentType] || 'Create high-quality, engaging content.'}

Remember to:
- Maintain brand consistency
- Include relevant call-to-actions
- Use appropriate tone for the platform
- Optimize for engagement and conversions`
}

function extractMetadata(content: string, contentType: string): any {
  const metadata: any = {}

  // Extract hashtags
  const hashtags = content.match(/#[\w]+/g) || []
  if (hashtags.length > 0) {
    metadata.hashtags = hashtags
  }

  // Extract mentions
  const mentions = content.match(/@[\w]+/g) || []
  if (mentions.length > 0) {
    metadata.mentions = mentions
  }

  // Extract URLs
  const urls = content.match(/https?:\/\/[^\s]+/g) || []
  if (urls.length > 0) {
    metadata.urls = urls
  }

  // Content analysis
  metadata.word_count = content.split(/\s+/).length
  metadata.character_count = content.length
  metadata.estimated_reading_time = Math.ceil(metadata.word_count / 200) // 200 WPM

  return metadata
}

// ====================
// 2. Dynamic Pricing Engine Function
// File: supabase/functions/dynamic-pricing-engine/index.ts
// ====================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const supabase = createClient(
  Deno.env.get('SUPABASE_URL') ?? '',
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
)

serve(async (req) => {
  try {
    const { ticket_category_id, quantity = 1, user_context = {} } = await req.json()

    // Get ticket category details
    const { data: ticketCategory } = await supabase
      .from('ticket_categories')
      .select(`
        *,
        event:events(*),
        pricing_rules(*)
      `)
      .eq('id', ticket_category_id)
      .single()

    if (!ticketCategory) {
      return new Response(JSON.stringify({ error: 'Ticket category not found' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    // Calculate dynamic price
    const basePricing = await calculateBasePricing(ticketCategory, quantity)
    const demandMultiplier = await calculateDemandMultiplier(ticketCategory)
    const timeMultiplier = await calculateTimeMultiplier(ticketCategory)
    const userMultiplier = await calculateUserMultiplier(user_context)
    const ruleAdjustments = await applyPricingRules(ticketCategory.pricing_rules, quantity)

    const finalPrice = Math.max(
      basePricing.price * demandMultiplier * timeMultiplier * userMultiplier + ruleAdjustments,
      basePricing.minimum_price || 0
    )

    const pricingBreakdown = {
      base_price: basePricing.price,
      quantity: quantity,
      subtotal: basePricing.price * quantity,
      demand_adjustment: (demandMultiplier - 1) * basePricing.price * quantity,
      time_adjustment: (timeMultiplier - 1) * basePricing.price * quantity,
      user_adjustment: (userMultiplier - 1) * basePricing.price * quantity,
      rule_adjustments: ruleAdjustments,
      final_price: finalPrice * quantity,
      unit_price: finalPrice,
      savings: Math.max(0, (basePricing.price * quantity) - (finalPrice * quantity))
    }

    return new Response(JSON.stringify({
      success: true,
      pricing: pricingBreakdown,
      valid_until: new Date(Date.now() + 15 * 60 * 1000).toISOString(), // 15 minutes
      factors: {
        demand_multiplier: demandMultiplier,
        time_multiplier: timeMultiplier,
        user_multiplier: userMultiplier
      }
    }), {
      headers: { 'Content-Type': 'application/json' }
    })

  } catch (error) {
    console.error('Dynamic pricing error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
})

async function calculateBasePricing(ticketCategory: any, quantity: number) {
  return {
    price: ticketCategory.price,
    minimum_price: ticketCategory.price * 0.5 // 50% minimum
  }
}

async function calculateDemandMultiplier(ticketCategory: any) {
  const soldPercentage = ticketCategory.quantity_sold / ticketCategory.quantity_total
  
  if (soldPercentage > 0.9) return 1.3  // 90%+ sold = 30% premium
  if (soldPercentage > 0.7) return 1.2  // 70%+ sold = 20% premium
  if (soldPercentage > 0.5) return 1.1  // 50%+ sold = 10% premium
  if (soldPercentage < 0.2) return 0.9  // Less than 20% sold = 10% discount
  
  return 1.0 // Normal pricing
}

async function calculateTimeMultiplier(ticketCategory: any) {
  const now = new Date()
  const eventStart = new Date(ticketCategory.event.start_date)
  const daysUntilEvent = Math.ceil((eventStart.getTime() - now.getTime()) / (1000 * 60 * 60 * 24))
  
  if (daysUntilEvent < 1) return 1.5   // Day of event = 50% premium
  if (daysUntilEvent < 3) return 1.3   // 1-3 days = 30% premium
  if (daysUntilEvent < 7) return 1.1   // 3-7 days = 10% premium
  if (daysUntilEvent > 60) return 0.8  // Early bird (60+ days) = 20% discount
  if (daysUntilEvent > 30) return 0.9  // 30+ days = 10% discount
  
  return 1.0 // Normal pricing
}

async function calculateUserMultiplier(userContext: any) {
  // Loyalty discount for returning customers
  if (userContext.previous_purchases > 5) return 0.9  // 10% loyalty discount
  if (userContext.previous_purchases > 2) return 0.95 // 5% loyalty discount
  
  // First-time user discount
  if (userContext.is_first_time_user) return 0.95
  
  return 1.0
}

async function applyPricingRules(pricingRules: any[], quantity: number) {
  let totalAdjustment = 0
  
  for (const rule of pricingRules) {
    if (!rule.is_active) continue
    
    const now = new Date()
    if (rule.valid_from && new Date(rule.valid_from) > now) continue
    if (rule.valid_until && new Date(rule.valid_until) < now) continue
    
    if (rule.usage_limit && rule.usage_count >= rule.usage_limit) continue
    
    // Apply rule based on conditions
    if (rule.conditions.min_quantity && quantity < rule.conditions.min_quantity) continue
    
    if (rule.discount_type === 'percentage') {
      totalAdjustment -= (rule.discount_value / 100)
    } else if (rule.discount_type === 'fixed_amount') {
      totalAdjustment -= rule.discount_value
    }
  }
  
  return totalAdjustment
}

// ====================
// 3. Payment Webhook Handler Function
// File: supabase/functions/payment-webhook/index.ts
// ====================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import Stripe from 'https://esm.sh/stripe@13.0.0'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY') ?? '', {
  apiVersion: '2023-10-16',
})

const supabase = createClient(
  Deno.env.get('SUPABASE_URL') ?? '',
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
)

serve(async (req) => {
  try {
    const body = await req.text()
    const signature = req.headers.get('stripe-signature')

    if (!signature) {
      return new Response('Missing stripe signature', { status: 400 })
    }

    // Verify webhook signature
    const event = stripe.webhooks.constructEvent(
      body,
      signature,
      Deno.env.get('STRIPE_WEBHOOK_SECRET') ?? ''
    )

    console.log(`Processing Stripe event: ${event.type}`)

    // Handle different event types
    switch (event.type) {
      case 'payment_intent.succeeded':
        await handlePaymentSuccess(event.data.object as Stripe.PaymentIntent)
        break
      
      case 'payment_intent.payment_failed':
        await handlePaymentFailed(event.data.object as Stripe.PaymentIntent)
        break
      
      case 'invoice.payment_succeeded':
        await handleSubscriptionPayment(event.data.object as Stripe.Invoice)
        break
      
      default:
        console.log(`Unhandled event type: ${event.type}`)
    }

    return new Response(JSON.stringify({ received: true }), {
      headers: { 'Content-Type': 'application/json' }
    })

  } catch (error) {
    console.error('Webhook error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }
})

async function handlePaymentSuccess(paymentIntent: Stripe.PaymentIntent) {
  try {
    // Update order status
    const { data: order, error: orderError } = await supabase
      .from('orders')
      .update({
        payment_status: 'paid',
        order_status: 'confirmed',
        payment_id: paymentIntent.id
      })
      .eq('payment_id', paymentIntent.id)
      .select()
      .single()

    if (orderError) throw orderError

    // Generate ticket codes
    await generateTicketCodes(order.id)

    // Send confirmation notifications
    await sendOrderConfirmation(order)

    // Update performance metrics
    await updateSalesMetrics(order)

    // Trigger post-purchase workflows  
    await triggerPostPurchaseWorkflows(order)

    console.log(`Payment succeeded for order: ${order.order_number}`)

  } catch (error) {
    console.error('Error handling payment success:', error)
  }
}

async function handlePaymentFailed(paymentIntent: Stripe.PaymentIntent) {
  try {
    // Update order status
    await supabase
      .from('orders')
      .update({
        payment_status: 'failed',
        order_status: 'cancelled'
      })
      .eq('payment_id', paymentIntent.id)

    // Send failure notification
    await sendPaymentFailedNotification(paymentIntent)

    console.log(`Payment failed for payment intent: ${paymentIntent.id}`)

  } catch (error) {
    console.error('Error handling payment failure:', error)
  }
}

async function generateTicketCodes(orderId: string) {
  const { data: orderItems } = await supabase
    .from('order_items')
    .select('*')
    .eq('order_id', orderId)

  for (const item of orderItems || []) {
    const ticketCodes = []
    for (let i = 0; i < item.quantity; i++) {
      ticketCodes.push(generateUniqueTicketCode())
    }

    await supabase
      .from('order_items')
      .update({ ticket_codes: ticketCodes })
      .eq('id', item.id)
  }
}

function generateUniqueTicketCode(): string {
  const timestamp = Date.now().toString(36)
  const random = Math.random().toString(36).substr(2, 5)
  return `TKT-${timestamp}-${random}`.toUpperCase()
}

async function sendOrderConfirmation(order: any) {
  // This would trigger your notification system
  await supabase
    .from('notification_campaigns')
    .insert({
      name: `Order Confirmation - ${order.order_number}`,
      recipient_criteria: { email: order.customer_email },
      template_id: 'order_confirmation',
      send_at: new Date().toISOString()
    })
}

// ====================
// 4. Workflow Automation Function
// File: supabase/functions/workflow-automation/index.ts
// ====================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const supabase = createClient(
  Deno.env.get('SUPABASE_URL') ?? '',
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
)

serve(async (req) => {
  try {
    const { workflow_id, trigger_data, event_id } = await req.json()

    // Get workflow configuration
    const { data: workflow } = await supabase
      .from('automation_workflows')
      .select('*')
      .eq('id', workflow_id)
      .single()

    if (!workflow || !workflow.is_active) {
      return new Response(JSON.stringify({ error: 'Workflow not found or inactive' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    // Create execution record
    const { data: execution } = await supabase
      .from('workflow_executions')
      .insert({
        workflow_id,
        event_id,
        trigger_data,
        execution_status: 'running'
      })
      .select()
      .single()

    try {
      // Execute workflow steps
      await executeWorkflowSteps(workflow.workflow_steps, trigger_data, execution.id)

      // Mark as completed
      await supabase
        .from('workflow_executions')
        .update({
          execution_status: 'completed',
          completed_at: new Date().toISOString()
        })
        .eq('id', execution.id)

      return new Response(JSON.stringify({
        success: true,
        execution_id: execution.id,
        status: 'completed'
      }), {
        headers: { 'Content-Type': 'application/json' }
      })

    } catch (error) {
      // Mark as failed
      await supabase
        .from('workflow_executions')
        .update({
          execution_status: 'failed',
          error_message: error.message,
          completed_at: new Date().toISOString()
        })
        .eq('id', execution.id)

      throw error
    }

  } catch (error) {
    console.error('Workflow execution error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
})

async function executeWorkflowSteps(steps: any[], triggerData: any, executionId: string) {
  for (const step of steps) {
    console.log(`Executing step: ${step.name}`)

    switch (step.type) {
      case 'email':
        await executeEmailStep(step, triggerData)
        break
      case 'webhook':
        await executeWebhookStep(step, triggerData)
        break
      case 'database_update':
        await executeDatabaseUpdateStep(step, triggerData)
        break
      case 'delay':
        await executeDelayStep(step)
        break
      case 'condition':
        const conditionResult = await executeConditionStep(step, triggerData)
        if (!conditionResult) {
          console.log(`Condition failed, skipping remaining steps`)
          break
        }
        break
      default:
        console.log(`Unknown step type: ${step.type}`)
    }

    // Log step execution
    await logStepExecution(executionId, step.name, 'completed')
  }
}

async function executeEmailStep(step: any, triggerData: any) {
  const emailData = {
    to: interpolateTemplate(step.to, triggerData),
    subject: interpolateTemplate(step.subject, triggerData),
    body: interpolateTemplate(step.body, triggerData)
  }

  // Send email via your email service
  console.log('Sending email:', emailData)
}

async function executeWebhookStep(step: any, triggerData: any) {
  const url = interpolateTemplate(step.url, triggerData)
  const payload = interpolateObject(step.payload, triggerData)

  const response = await fetch(url, {
    method: step.method || 'POST',
    headers: {
      'Content-Type': 'application/json',
      ...step.headers
    },
    body: JSON.stringify(payload)
  })

  if (!response.ok) {
    throw new Error(`Webhook failed: ${response.status} ${response.statusText}`)
  }
}

async function executeDatabaseUpdateStep(step: any, triggerData: any) {
  const tableName = step.table
  const updates = interpolateObject(step.updates, triggerData)
  const conditions = interpolateObject(step.conditions, triggerData)

  // Build query conditions
  let query = supabase.from(tableName).update(updates)
  
  for (const [field, value] of Object.entries(conditions)) {
    query = query.eq(field, value)
  }

  const { error } = await query
  if (error) throw error
}

async function executeDelayStep(step: any) {
  const delayMs = step.delay_ms || 1000
  await new Promise(resolve => setTimeout(resolve, delayMs))
}

async function executeConditionStep(step: any, triggerData: any): Promise<boolean> {
  const { field, operator, value } = step.condition
  const actualValue = getNestedValue(triggerData, field)

  switch (operator) {
    case 'equals':
      return actualValue === value
    case 'not_equals':
      return actualValue !== value
    case 'greater_than':
      return actualValue > value
    case 'less_than':
      return actualValue < value
    case 'contains':
      return String(actualValue).includes(value)
    default:
      return true
  }
}

function interpolateTemplate(template: string, data: any): string {
  return template.replace(/\{\{(\w+(?:\.\w+)*)\}\}/g, (match, path) => {
    return getNestedValue(data, path) || match
  })
}

function interpolateObject(obj: any, data: any): any {
  if (typeof obj === 'string') {
    return interpolateTemplate(obj, data)
  } else if (Array.isArray(obj)) {
    return obj.map(item => interpolateObject(item, data))
  } else if (typeof obj === 'object' && obj !== null) {
    const result: any = {}
    for (const [key, value] of Object.entries(obj)) {
      result[key] = interpolateObject(value, data)
    }
    return result
  }
  return obj
}

function getNestedValue(obj: any, path: string): any {
  return path.split('.').reduce((current, key) => current?.[key], obj)
}

async function logStepExecution(executionId: string, stepName: string, status: string) {
  // Log step execution for debugging
  console.log(`Step ${stepName}: ${status}`)
}

// ====================
// 5. Analytics Processing Function
// File: supabase/functions/analytics-processor/index.ts
// ====================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const supabase = createClient(
  Deno.env.get('SUPABASE_URL') ?? '',
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
)

serve(async (req) => {
  try {
    const { process_type = 'daily', date_range } = await req.json()

    let startDate: Date
    let endDate: Date

    if (date_range) {
      startDate = new Date(date_range.start)
      endDate = new Date(date_range.end)
    } else {
      // Default to yesterday's data
      endDate = new Date()
      endDate.setHours(0, 0, 0, 0)
      startDate = new Date(endDate)
      startDate.setDate(startDate.getDate() - 1)
    }

    console.log(`Processing analytics for ${startDate.toISOString()} to ${endDate.toISOString()}`)

    // Process different types of analytics
    await Promise.all([
      processEventMetrics(startDate, endDate),
      processTicketSalesMetrics(startDate, endDate),
      processSponsorshipMetrics(startDate, endDate),
      processMarketingMetrics(startDate, endDate),
      processUserEngagementMetrics(startDate, endDate)
    ])

    return new Response(JSON.stringify({
      success: true,
      processed_period: {
        start: startDate.toISOString(),
        end: endDate.toISOString()
      }
    }), {
      headers: { 'Content-Type': 'application/json' }
    })

  } catch (error) {
    console.error('Analytics processing error:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
})

async function processEventMetrics(startDate: Date, endDate: Date) {
  // Calculate event performance metrics
  const { data: events } = await supabase
    .from('events')
    .select(`
      id,
      organization_id,
      name,
      start_date,
      orders(total_amount, order_status),
      ticket_categories(quantity_total, quantity_sold)
    `)
    .gte('start_date', startDate.toISOString())
    .lte('start_date', endDate.toISOString())

  for (const event of events || []) {
    const totalRevenue = event.orders
      .filter((order: any) => order.order_status === 'confirmed')
      .reduce((sum: number, order: any) => sum + order.total_amount, 0)

    const totalCapacity = event.ticket_categories
      .reduce((sum: number, category: any) => sum + category.quantity_total, 0)

    const totalSold = event.ticket_categories
      .reduce((sum: number, category: any) => sum + category.quantity_sold, 0)

    const sellThroughRate = totalCapacity > 0 ? (totalSold / totalCapacity) * 100 : 0

    await supabase
      .from('performance_metrics')
      .upsert({
        organization_id: event.organization_id,
        event_id: event.id,
        metric_name: 'event_performance',
        metric_category: 'events',
        metric_value: totalRevenue,
        dimensions: {
          total_capacity: totalCapacity,
          total_sold: totalSold,
          sell_through_rate: sellThroughRate
        },
        period_start: startDate.toISOString(),
        period_end: endDate.toISOString()
      })
  }
}

async function processTicketSalesMetrics(startDate: Date, endDate: Date) {
  // Aggregate ticket sales data
  const { data: salesData } = await supabase
    .from('orders')
    .select(`
      organization_id,
      event_id,
      total_amount,
      created_at,
      order_items(quantity, ticket_category_id)
    `)
    .gte('created_at', startDate.toISOString())
    .lte('created_at', endDate.toISOString())
    .eq('order_status', 'confirmed')

  // Group by organization and event
  const groupedSales = salesData?.reduce((acc: any, order: any) => {
    const key = `${order.organization_id}-${order.event_id}`
    if (!acc[key]) {
      acc[key] = {
        organization_id: order.organization_id,
        event_id: order.event_id,
        total_revenue: 0,
        total_tickets: 0,
        order_count: 0
      }
    }
    acc[key].total_revenue += order.total_amount
    acc[key].total_tickets += order.order_items.reduce((sum: number, item: any) => sum + item.quantity, 0)
    acc[key].order_count += 1
    return acc
  }, {})

  // Save aggregated metrics
  for (const salesMetric of Object.values(groupedSales || {})) {
    await supabase
      .from('performance_metrics')
      .upsert({
        ...salesMetric,
        metric_name: 'ticket_sales',
        metric_category: 'sales',
        metric_value: (salesMetric as any).total_revenue,
        dimensions: {
          total_tickets: (salesMetric as any).total_tickets,
          order_count: (salesMetric as any).order_count,
          average_order_value: (salesMetric as any).total_revenue / (salesMetric as any).order_count
        },
        period_start: startDate.toISOString(),
        period_end: endDate.toISOString()
      })
  }
}

async function processSponsorshipMetrics(startDate: Date, endDate: Date) {
  // Calculate sponsorship performance
  const { data: sponsorships } = await supabase
    .from('sponsorship_deals')
    .select('organization_id, event_id, deal_value, status')
    .gte('created_at', startDate.toISOString())
    .lte('created_at', endDate.toISOString())

  const sponsorshipMetrics = sponsorships?.reduce((acc: any, deal: any) => {
    const key = `${deal.organization_id}-${deal.event_id}`
    if (!acc[key]) {
      acc[key] = {
        organization_id: deal.organization_id,
        event_id: deal.event_id,
        total_value: 0,
        deal_count: 0,
        signed_count: 0
      }
    }
    acc[key].total_value += deal.deal_value
    acc[key].deal_count += 1
    if (deal.status === 'signed') {
      acc[key].signed_count += 1
    }
    return acc
  }, {})

  for (const metric of Object.values(sponsorshipMetrics || {})) {
    await supabase
      .from('performance_metrics')
      .upsert({
        ...metric,
        metric_name: 'sponsorship_performance',
        metric_category: 'sponsorship',
        metric_value: (metric as any).total_value,
        dimensions: {
          deal_count: (metric as any).deal_count,
          signed_count: (metric as any).signed_count,
          conversion_rate: (metric as any).signed_count / (metric as any).deal_count * 100
        },
        period_start: startDate.toISOString(),
        period_end: endDate.toISOString()
      })
  }
}

async function processMarketingMetrics(startDate: Date, endDate: Date) {
  // Process social media and marketing performance
  const { data: socialPosts } = await supabase
    .from('social_media_posts')
    .select(`
      campaign_id,
      engagement_metrics,
      marketing_campaigns(organization_id, event_id)
    `)
    .gte('published_at', startDate.toISOString())
    .lte('published_at', endDate.toISOString())
    .eq('status', 'published')

  const marketingMetrics = socialPosts?.reduce((acc: any, post: any) => {
    if (!post.marketing_campaigns) return acc

    const key = `${post.marketing_campaigns.organization_id}-${post.marketing_campaigns.event_id}`
    if (!acc[key]) {
      acc[key] = {
        organization_id: post.marketing_campaigns.organization_id,
        event_id: post.marketing_campaigns.event_id,
        total_engagement: 0,
        post_count: 0,
        total_reach: 0
      }
    }

    if (post.engagement_metrics) {
      acc[key].total_engagement += (post.engagement_metrics.likes || 0) + 
                                   (post.engagement_metrics.comments || 0) + 
                                   (post.engagement_metrics.shares || 0)
      acc[key].total_reach += post.engagement_metrics.reach || 0
    }
    acc[key].post_count += 1
    return acc
  }, {})

  for (const metric of Object.values(marketingMetrics || {})) {
    await supabase
      .from('performance_metrics')
      .upsert({
        ...metric,
        metric_name: 'marketing_performance',
        metric_category: 'marketing',
        metric_value: (metric as any).total_engagement,
        dimensions: {
          post_count: (metric as any).post_count,
          total_reach: (metric as any).total_reach,
          engagement_rate: (metric as any).total_reach > 0 ? 
            (metric as any).total_engagement / (metric as any).total_reach * 100 : 0
        },
        period_start: startDate.toISOString(),
        period_end: endDate.toISOString()
      })
  }
}

async function processUserEngagementMetrics(startDate: Date, endDate: Date) {
  // Calculate user engagement metrics
  const { data: analyticsEvents } = await supabase
    .from('analytics_events')
    .select('organization_id, event_id, event_name, user_id, session_id')
    .gte('created_at', startDate.toISOString())
    .lte('created_at', endDate.toISOString())

  const engagementMetrics = analyticsEvents?.reduce((acc: any, event: any) => {
    const key = `${event.organization_id}-${event.event_id || 'global'}`
    if (!acc[key]) {
      acc[key] = {
        organization_id: event.organization_id,
        event_id: event.event_id,
        unique_users: new Set(),
        unique_sessions: new Set(),
        total_events: 0
      }
    }
    
    if (event.user_id) acc[key].unique_users.add(event.user_id)
    if (event.session_id) acc[key].unique_sessions.add(event.session_id)
    acc[key].total_events += 1
    return acc
  }, {})

  for (const [key, metric] of Object.entries(engagementMetrics || {})) {
    await supabase
      .from('performance_metrics')
      .upsert({
        organization_id: (metric as any).organization_id,
        event_id: (metric as any).event_id,
        metric_name: 'user_engagement',
        metric_category: 'engagement',
        metric_value: (metric as any).total_events,
        dimensions: {
          unique_users: (metric as any).unique_users.size,
          unique_sessions: (metric as any).unique_sessions.size,
          events_per_user: (metric as any).total_events / (metric as any).unique_users.size
        },
        period_start: startDate.toISOString(),
        period_end: endDate.toISOString()
      })
  }
}