// FashionOS WhatsApp Integration Example
// This demonstrates how to integrate WAHA with FashionOS for event notifications

const axios = require('axios');

class FashionOSWhatsApp {
    constructor() {
        this.baseURL = 'http://localhost:3000/api';
        this.session = 'default';
        this.apiKey = 'fashionos-waha-key-2024';
    }

    // Send text message
    async sendMessage(phoneNumber, message) {
        try {
            const response = await axios.post(`${this.baseURL}/sendText`, {
                session: this.session,
                chatId: `${phoneNumber}@c.us`,
                text: message
            }, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-Api-Key': this.apiKey
                }
            });
            
            console.log('✅ Message sent successfully:', response.data);
            return response.data;
        } catch (error) {
            console.error('❌ Failed to send message:', error.response?.data || error.message);
            throw error;
        }
    }

    // Send image with caption
    async sendImage(phoneNumber, imageUrl, caption) {
        try {
            const response = await axios.post(`${this.baseURL}/sendImage`, {
                session: this.session,
                chatId: `${phoneNumber}@c.us`,
                file: { url: imageUrl },
                caption: caption
            }, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-Api-Key': this.apiKey
                }
            });
            
            console.log('✅ Image sent successfully:', response.data);
            return response.data;
        } catch (error) {
            console.error('❌ Failed to send image:', error.response?.data || error.message);
            throw error;
        }
    }

    // Check session status
    async getSessionStatus() {
        try {
            const response = await axios.get(`${this.baseURL}/sessions/${this.session}/status`);
            return response.data;
        } catch (error) {
            console.error('❌ Failed to get session status:', error.response?.data || error.message);
            throw error;
        }
    }

    // FashionOS specific methods

    // Send event registration confirmation
    async sendEventConfirmation(attendee) {
        const message = `🎉 ¡Confirmación de Registro - FashionOS!

Hola ${attendee.name},

Tu registro para el evento "${attendee.eventName}" ha sido confirmado.

📅 Fecha: ${attendee.eventDate}
🕐 Hora: ${attendee.eventTime}
📍 Ubicación: ${attendee.venue}
🎫 Código: ${attendee.ticketCode}

¡Te esperamos! Para más información visita: ${attendee.eventUrl}

FashionOS Team 💫`;

        return await this.sendMessage(attendee.phone, message);
    }

    // Send event reminder
    async sendEventReminder(attendee) {
        const message = `⏰ Recordatorio - ${attendee.eventName}

Hola ${attendee.name},

Te recordamos que tu evento es mañana:

📅 ${attendee.eventDate}
🕐 ${attendee.eventTime}
📍 ${attendee.venue}

¡No olvides tu código de entrada: ${attendee.ticketCode}

¡Nos vemos pronto! 🌟`;

        return await this.sendMessage(attendee.phone, message);
    }

    // Send sponsor welcome message
    async sendSponsorWelcome(sponsor) {
        const message = `🤝 ¡Bienvenido a FashionOS!

Estimado ${sponsor.contactName},

Gracias por ser parte de ${sponsor.eventName} como sponsor ${sponsor.tier}.

📋 Detalles de tu patrocinio:
• Paquete: ${sponsor.packageName}
• Beneficios: ${sponsor.benefits.join(', ')}
• Contacto del evento: ${sponsor.eventManager}

Pronto recibirás más información sobre la activación de tu patrocinio.

¡Gracias por apoyar la moda colombiana! 🇨🇴✨`;

        return await this.sendMessage(sponsor.phone, message);
    }

    // Send designer showcase notification
    async sendDesignerShowcase(designer, showcase) {
        const imageUrl = showcase.posterUrl;
        const caption = `✨ ¡Nuevo Showcase Disponible!

${designer.name} presenta: "${showcase.title}"

📸 ${showcase.description}

🔗 Ver colección completa: ${showcase.url}

#FashionOS #DiseñoColombiano #${designer.brand}`;

        return await this.sendImage(designer.phone, imageUrl, caption);
    }

    // Broadcast to multiple recipients
    async broadcastMessage(phoneNumbers, message) {
        const results = [];
        
        for (const phone of phoneNumbers) {
            try {
                const result = await this.sendMessage(phone, message);
                results.push({ phone, success: true, result });
                
                // Add delay to avoid rate limiting
                await new Promise(resolve => setTimeout(resolve, 1000));
            } catch (error) {
                results.push({ phone, success: false, error: error.message });
            }
        }
        
        return results;
    }

    // Set up webhook for incoming messages
    async setupWebhook(webhookUrl) {
        try {
            const response = await axios.post(`${this.baseURL}/webhook`, {
                session: this.session,
                url: webhookUrl
            }, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-Api-Key': this.apiKey
                }
            });
            
            console.log('✅ Webhook configured:', response.data);
            return response.data;
        } catch (error) {
            console.error('❌ Failed to setup webhook:', error.response?.data || error.message);
            throw error;
        }
    }
}

// Usage examples
async function examples() {
    const whatsapp = new FashionOSWhatsApp();
    
    // Check if session is working
    try {
        const status = await whatsapp.getSessionStatus();
        console.log('Session status:', status);
        
        if (status.status !== 'WORKING') {
            console.log('⚠️  Session not connected. Please scan QR code in dashboard.');
            return;
        }
    } catch (error) {
        console.log('❌ Cannot connect to WAHA. Make sure it\'s running.');
        return;
    }

    // Example 1: Event confirmation
    const attendee = {
        name: 'María García',
        phone: '573001234567', // Replace with actual number
        eventName: 'Bogotá Fashion Week 2024',
        eventDate: '15 de Marzo, 2024',
        eventTime: '7:00 PM',
        venue: 'Centro de Convenciones Ágora',
        ticketCode: 'BFW2024-001',
        eventUrl: 'https://fashionos.co/events/bfw2024'
    };
    
    // await whatsapp.sendEventConfirmation(attendee);

    // Example 2: Sponsor welcome
    const sponsor = {
        contactName: 'Carlos Rodríguez',
        phone: '573009876543', // Replace with actual number
        eventName: 'Medellín Fashion Show',
        tier: 'Gold',
        packageName: 'Paquete Oro',
        benefits: ['Logo en materiales', 'Stand premium', 'Networking VIP'],
        eventManager: 'Ana López - ana@fashionos.co'
    };
    
    // await whatsapp.sendSponsorWelcome(sponsor);

    console.log('✅ Integration examples ready. Uncomment lines to test.');
}

// Run examples if this file is executed directly
if (require.main === module) {
    examples().catch(console.error);
}

module.exports = FashionOSWhatsApp;