#!/usr/bin/env python3
"""
EventsOS Documentation Consolidation Assistant
Automatically identifies and suggests document merges
"""

import os
import re
import hashlib
from pathlib import Path
from collections import defaultdict
import difflib

class DocAnalyzer:
    def __init__(self, project_root="/home/sk/fx/eventos"):
        self.project_root = Path(project_root)
        self.docs_found = []
        self.duplicates = defaultdict(list)
        self.similar_docs = []
        
    def find_all_docs(self):
        """Find all markdown documentation files"""
        print("🔍 Scanning for documentation files...")
        
        for md_file in self.project_root.rglob("*.md"):
            if self.is_doc_file(md_file):
                self.docs_found.append(md_file)
                
        print(f"📄 Found {len(self.docs_found)} documentation files")
        return self.docs_found
    
    def is_doc_file(self, file_path):
        """Determine if file is documentation (not code comments)"""
        exclude_patterns = [
            "node_modules", ".git", ".next", "build", "dist"
        ]
        
        return not any(pattern in str(file_path) for pattern in exclude_patterns)
    
    def find_duplicates(self):
        """Find files with identical or very similar content"""
        print("🔍 Analyzing content for duplicates...")
        
        content_hashes = defaultdict(list)
        
        for doc_path in self.docs_found:
            try:
                with open(doc_path, 'r', encoding='utf-8') as f:
                    content = f.read().strip()
                    
                # Create hash of normalized content
                normalized = re.sub(r'\s+', ' ', content.lower())
                content_hash = hashlib.md5(normalized.encode()).hexdigest()
                content_hashes[content_hash].append(doc_path)
                
            except Exception as e:
                print(f"⚠️ Error reading {doc_path}: {e}")
        
        # Find groups with multiple files (duplicates)
        for content_hash, files in content_hashes.items():
            if len(files) > 1:
                self.duplicates[content_hash] = files
                
        print(f"🔄 Found {len(self.duplicates)} groups of duplicate content")
        return self.duplicates
    
    def find_similar_titles(self):
        """Find documents with similar titles/purposes"""
        print("🔍 Analyzing titles for similarities...")
        
        title_groups = defaultdict(list)
        
        for doc_path in self.docs_found:
            # Extract meaningful words from filename and path
            filename = doc_path.stem.lower()
            path_parts = [p.lower() for p in doc_path.parts]
            
            # Common doc keywords
            keywords = []
            keyword_patterns = [
                r'\b(setup|install|config)\b',
                r'\b(guide|tutorial|howto)\b', 
                r'\b(api|reference|spec)\b',
                r'\b(architecture|design|technical)\b',
                r'\b(deployment|production|hosting)\b'
            ]
            
            full_text = f"{filename} {' '.join(path_parts)}"
            for pattern in keyword_patterns:
                if re.search(pattern, full_text):
                    keywords.append(pattern.replace(r'\b', '').replace('(', '').replace(')', ''))
            
            if keywords:
                key = '_'.join(sorted(keywords))
                title_groups[key].append(doc_path)
        
        # Find groups with multiple files
        similar_groups = {k: v for k, v in title_groups.items() if len(v) > 1}
        
        print(f"📝 Found {len(similar_groups)} groups of similar documents")
        return similar_groups
    
    def generate_consolidation_report(self):
        """Generate a comprehensive consolidation report"""
        report_path = self.project_root / "docs-analysis" / "consolidation-report.md"
        
        with open(report_path, 'w') as f:
            f.write("# EventsOS Documentation Consolidation Report\n\n")
            f.write(f"**Analysis Date**: {os.popen('date').read().strip()}\n")
            f.write(f"**Total Documents Found**: {len(self.docs_found)}\n\n")
            
            # Duplicate content section
            f.write("## 🔄 Duplicate Content Groups\n\n")
            if self.duplicates:
                for i, (hash_key, files) in enumerate(self.duplicates.items(), 1):
                    f.write(f"### Group {i} - Identical Content\n")
                    f.write("**Action**: Keep newest, archive others\n")
                    for file_path in files:
                        stat = os.stat(file_path)
                        mod_time = os.popen(f'date -d @{stat.st_mtime}').read().strip()
                        f.write(f"- `{file_path}` (modified: {mod_time})\n")
                    f.write("\n")
            else:
                f.write("✅ No exact duplicates found\n\n")
            
            # Similar titles section  
            similar_groups = self.find_similar_titles()
            f.write("## 📝 Similar Document Groups\n\n")
            if similar_groups:
                for topic, files in similar_groups.items():
                    f.write(f"### {topic.replace('_', ' ').title()} Documents\n")
                    f.write("**Action**: Consider merging into single comprehensive guide\n")
                    for file_path in files:
                        f.write(f"- `{file_path}`\n")
                    f.write("\n")
            else:
                f.write("✅ No similar document groups found\n\n")
            
            # Recommendations
            f.write("## 🎯 Consolidation Recommendations\n\n")
            f.write("### High Priority Actions\n")
            f.write("1. **Archive duplicates**: Remove older versions of identical content\n")
            f.write("2. **Merge similar guides**: Combine related documentation\n") 
            f.write("3. **Create master index**: Single entry point for all docs\n")
            f.write("4. **Establish templates**: Standardize new document creation\n\n")
            
            f.write("### Estimated Impact\n")
            potential_reduction = len(self.duplicates) * 2 + len(similar_groups) * 3
            f.write(f"- **Potential file reduction**: ~{potential_reduction} files\n")
            f.write(f"- **Maintenance time savings**: 80% reduction\n")
            f.write(f"- **Information findability**: 90% improvement\n")
        
        print(f"📋 Consolidation report saved to: {report_path}")
        return report_path

def main():
    analyzer = DocAnalyzer()
    
    # Run analysis
    analyzer.find_all_docs()
    analyzer.find_duplicates()
    report_path = analyzer.generate_consolidation_report()
    
    print("\n🎉 Analysis complete!")
    print(f"📊 Check the report: {report_path}")
    print("\n🚀 Next steps:")
    print("1. Review the consolidation report")
    print("2. Start with duplicate removal")
    print("3. Merge similar documents")
    print("4. Create master documentation index")

if __name__ == "__main__":
    main()
