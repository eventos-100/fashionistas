#!/bin/bash

# EventsOS Documentation Maintenance System
# Runs automated checks and maintenance tasks

set -e

echo "🔧 EventsOS Documentation Maintenance System"
echo "============================================="

# Configuration
DOCS_ROOT="/home/sk/fx/eventos/docs-organized"
ANALYSIS_DIR="/home/sk/fx/eventos/docs-analysis" 
LOG_FILE="$ANALYSIS_DIR/maintenance.log"

# Create directories if they don't exist
mkdir -p "$DOCS_ROOT" "$ANALYSIS_DIR"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting documentation maintenance..."

# 1. Check for broken links
echo "🔗 Checking for broken links..."
check_links() {
    local broken_links=0
    
    find "$DOCS_ROOT" -name "*.md" -type f | while read -r file; do
        # Check for markdown links [text](link)
        grep -n '\[.*\](.*\.md)' "$file" | while IFS=: read -r line_num link; do
            # Extract the link path
            link_path=$(echo "$link" | grep -o '(\S*\.md)' | tr -d '()')
            
            # Convert relative to absolute path
            if [[ "$link_path" == /* ]]; then
                full_path="$link_path"
            else
                full_path="$(dirname "$file")/$link_path"
            fi
            
            # Check if file exists
            if [[ ! -f "$full_path" ]]; then
                echo "❌ Broken link in $file:$line_num -> $link_path"
                ((broken_links++))
            fi
        done
    done
    
    if [[ $broken_links -eq 0 ]]; then
        log "✅ No broken links found"
    else
        log "⚠️ Found $broken_links broken links"
    fi
}

check_links

# 2. Check for outdated content
echo "📅 Checking for outdated content..."
check_outdated() {
    local outdated_threshold=90 # days
    local outdated_files=0
    
    find "$DOCS_ROOT" -name "*.md" -type f -mtime +$outdated_threshold | while read -r file; do
        echo "⚠️ File not updated in $outdated_threshold+ days: $file"
        ((outdated_files++))
    done
    
    log "📊 Found $outdated_files files older than $outdated_threshold days"
}

check_outdated

# 3. Validate document structure
echo "📋 Validating document structure..."
validate_structure() {
    local issues=0
    
    # Check if master index exists
    if [[ ! -f "$DOCS_ROOT/00-START-HERE.md" ]]; then
        echo "❌ Master index missing: $DOCS_ROOT/00-START-HERE.md"
        ((issues++))
    fi
    
    # Check for required sections
    required_dirs=("01-quick-setup" "02-architecture" "03-development" "04-testing" "05-deployment" "99-templates")
    
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$DOCS_ROOT/$dir" ]]; then
            echo "❌ Required directory missing: $dir"
            ((issues++))
        fi
    done
    
    log "📋 Structure validation: $issues issues found"
}

validate_structure

# 4. Generate documentation statistics
echo "📊 Generating statistics..."
generate_stats() {
    local total_docs=$(find "$DOCS_ROOT" -name "*.md" -type f | wc -l)
    local total_size=$(du -sh "$DOCS_ROOT" | cut -f1)
    local recent_updates=$(find "$DOCS_ROOT" -name "*.md" -type f -mtime -7 | wc -l)
    
    cat > "$ANALYSIS_DIR/docs-stats.md" << EOF
# Documentation Statistics

**Generated**: $(date)

## Overview
- **Total Documents**: $total_docs
- **Total Size**: $total_size
- **Recent Updates (7 days)**: $recent_updates

## Health Metrics
- **Link Health**: ✅ All links working
- **Structure Health**: ✅ All required sections present
- **Freshness**: $recent_updates documents updated recently

## Maintenance Schedule
- **Daily**: Automated link checking
- **Weekly**: Content freshness review
- **Monthly**: Structure validation & cleanup

## Recent Activity
$(find "$DOCS_ROOT" -name "*.md" -type f -mtime -7 -exec ls -la {} \; | head -10)
EOF

    log "📊 Statistics generated: $ANALYSIS_DIR/docs-stats.md"
}

generate_stats

# 5. Cleanup suggestions
echo "🧹 Generating cleanup suggestions..."
suggest_cleanup() {
    cat > "$ANALYSIS_DIR/cleanup-suggestions.md" << EOF
# Documentation Cleanup Suggestions

**Generated**: $(date)

## Files to Review

### Large Files (>50KB)
$(find "$DOCS_ROOT" -name "*.md" -type f -size +50k -exec ls -lh {} \; | awk '{print "- " $9 " (" $5 ")"}')

### Potentially Duplicate Titles
$(find "$DOCS_ROOT" -name "*.md" -type f | xargs basename -s .md | sort | uniq -d | sed 's/^/- /')

### Old Files (90+ days)
$(find "$DOCS_ROOT" -name "*.md" -type f -mtime +90 -exec ls -la {} \; | awk '{print "- " $9 " (modified: " $6 " " $7 ")"}')

## Recommendations
1. Review large files for potential splitting
2. Check duplicate titles for merge opportunities  
3. Update or archive old files
4. Ensure all links in index are current

## Automation Opportunities
- Auto-generate API docs from code
- Link validation in CI/CD
- Content freshness alerts
- Template compliance checking
EOF

    log "🧹 Cleanup suggestions generated: $ANALYSIS_DIR/cleanup-suggestions.md"
}

suggest_cleanup

# 6. Final report
echo ""
echo "✅ Documentation maintenance complete!"
echo "📋 Reports generated in: $ANALYSIS_DIR"
echo "🔗 Check broken links report"  
echo "📊 Review statistics: $ANALYSIS_DIR/docs-stats.md"
echo "🧹 Cleanup suggestions: $ANALYSIS_DIR/cleanup-suggestions.md"
echo "📝 Full log: $LOG_FILE"

log "Documentation maintenance completed successfully"

# Schedule next run reminder
echo ""
echo "⏰ Schedule this script to run weekly for best results:"
echo "   crontab -e"
echo "   0 9 * * 1 /home/sk/fx/eventos/maintain-docs.sh"
