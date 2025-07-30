#!/bin/bash

# EventsOS Documentation Analysis Script
# Purpose: Identify duplicate content and categorize documents

echo "🔍 Analyzing EventsOS Documentation..."
echo "================================"

# Create analysis directory
mkdir -p /home/sk/fx/eventos/docs-analysis

# Find all markdown files
echo "📄 Finding all documentation files..."
find /home/sk/fx/eventos -name "*.md" -type f > /home/sk/fx/eventos/docs-analysis/all-docs.txt

# Count total files
TOTAL_DOCS=$(cat /home/sk/fx/eventos/docs-analysis/all-docs.txt | wc -l)
echo "Total .md files found: $TOTAL_DOCS"

# Categorize by content patterns
echo "🏷️ Categorizing documents..."

# Setup & Installation docs
grep -l -i "setup\|install\|configuration" /home/sk/fx/eventos/**/*.md 2>/dev/null > /home/sk/fx/eventos/docs-analysis/setup-docs.txt 2>/dev/null || true

# Technical Architecture docs  
grep -l -i "architecture\|technical\|stack\|framework" /home/sk/fx/eventos/**/*.md 2>/dev/null > /home/sk/fx/eventos/docs-analysis/architecture-docs.txt 2>/dev/null || true

# Business & Requirements docs
grep -l -i "requirements\|business\|spec\|srs" /home/sk/fx/eventos/**/*.md 2>/dev/null > /home/sk/fx/eventos/docs-analysis/business-docs.txt 2>/dev/null || true

# Development guides
grep -l -i "development\|guide\|tutorial\|implementation" /home/sk/fx/eventos/**/*.md 2>/dev/null > /home/sk/fx/eventos/docs-analysis/dev-docs.txt 2>/dev/null || true

# Create summary report
echo "📊 Generating analysis report..."
cat << EOF > /home/sk/fx/eventos/docs-analysis/analysis-report.md
# EventsOS Documentation Analysis Report

## Summary
- **Total Documents**: $TOTAL_DOCS
- **Setup/Config**: $(wc -l < /home/sk/fx/eventos/docs-analysis/setup-docs.txt 2>/dev/null || echo 0)
- **Architecture**: $(wc -l < /home/sk/fx/eventos/docs-analysis/architecture-docs.txt 2>/dev/null || echo 0)  
- **Business/Specs**: $(wc -l < /home/sk/fx/eventos/docs-analysis/business-docs.txt 2>/dev/null || echo 0)
- **Development**: $(wc -l < /home/sk/fx/eventos/docs-analysis/dev-docs.txt 2>/dev/null || echo 0)

## Recommended Actions
1. Consolidate setup docs into single guide
2. Merge architecture documents  
3. Create single requirements document
4. Organize dev guides by technology

## Priority Cleanup Targets
- Documents with "DRAFT" or "TEMP" in filename
- Files modified >30 days ago with newer versions
- Documents with similar titles
EOF

echo "✅ Analysis complete! Check /home/sk/fx/eventos/docs-analysis/"
echo "📋 Next: Review analysis-report.md for recommendations"
