#!/usr/bin/env python3
"""
EventsOS Project Status Dashboard
Real-time project monitoring and quick actions
"""

import os
import json
import subprocess
import time
from datetime import datetime
from pathlib import Path

class EventsOSDashboard:
    def __init__(self):
        self.project_root = Path("/home/sk/fx/eventos")
        self.zone_template = self.project_root / "zone-template"
        self.docs_dir = self.project_root / "docs"
        
    def get_project_status(self):
        """Get comprehensive project status"""
        status = {
            "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "zone_template": self.check_zone_template(),
            "documentation": self.check_documentation(),
            "development": self.check_development_status(),
            "next_actions": self.get_next_actions()
        }
        return status
    
    def check_zone_template(self):
        """Check Zone template status"""
        template_status = {
            "exists": self.zone_template.exists(),
            "has_package_json": (self.zone_template / "package.json").exists(),
            "has_node_modules": (self.zone_template / "node_modules").exists(),
            "server_running": self.check_if_server_running(),
            "last_modified": self.get_last_modified(self.zone_template)
        }
        
        # Check if we can start the server
        if template_status["exists"] and template_status["has_package_json"]:
            template_status["ready_to_run"] = True
            template_status["start_command"] = "cd zone-template && npm run dev"
        else:
            template_status["ready_to_run"] = False
            template_status["issues"] = []
            if not template_status["exists"]:
                template_status["issues"].append("Zone template directory not found")
            if not template_status["has_package_json"]:
                template_status["issues"].append("package.json missing")
                
        return template_status
    
    def check_documentation(self):
        """Check documentation status"""
        docs_status = {
            "master_index": (self.docs_dir / "README.md").exists(),
            "quick_start": (self.docs_dir / "01-quick-start").exists(),
            "zone_adaptation": (self.docs_dir / "02-zone-adaptation").exists(),
            "total_docs": len(list(self.docs_dir.rglob("*.md"))) if self.docs_dir.exists() else 0,
            "organized": self.docs_dir.exists(),
            "last_updated": self.get_last_modified(self.docs_dir) if self.docs_dir.exists() else "Never"
        }
        
        # Check key documentation files
        key_docs = [
            "README.md",
            "01-quick-start/installation.md", 
            "01-quick-start/zone-overview.md",
            "02-zone-adaptation/page-mapping.md",
            "02-zone-adaptation/content-guide.md",
            "02-zone-adaptation/asset-replacement.md"
        ]
        
        docs_status["key_docs_present"] = {}
        for doc in key_docs:
            docs_status["key_docs_present"][doc] = (self.docs_dir / doc).exists()
            
        return docs_status
    
    def check_development_status(self):
        """Check development environment status"""
        dev_status = {
            "node_version": self.get_node_version(),
            "npm_available": self.check_command_available("npm"),
            "git_status": self.get_git_status(),
            "scripts_executable": self.check_scripts_executable()
        }
        return dev_status
    
    def get_next_actions(self):
        """Determine immediate next actions based on current state"""
        actions = []
        
        # Check Zone template status
        if not self.zone_template.exists():
            actions.append({
                "priority": "HIGH",
                "action": "Setup Zone template",
                "command": "cd /home/sk/fx/eventos && ./setup.sh",
                "description": "Zone template directory not found"
            })
        elif not (self.zone_template / "node_modules").exists():
            actions.append({
                "priority": "HIGH", 
                "action": "Install dependencies",
                "command": "cd zone-template && npm install",
                "description": "Node modules not installed"
            })
        elif not self.check_if_server_running():
            actions.append({
                "priority": "MEDIUM",
                "action": "Start development server", 
                "command": "./start-zone.sh",
                "description": "Development server not running"
            })
        else:
            actions.append({
                "priority": "LOW",
                "action": "Begin content adaptation",
                "command": "Open http://localhost:3012/travel",
                "description": "Ready to start adapting travel content to events"
            })
            
        # Check documentation completeness
        if not self.docs_dir.exists():
            actions.append({
                "priority": "MEDIUM",
                "action": "Setup documentation", 
                "command": "mkdir -p docs && cp docs-organized/* docs/",
                "description": "Documentation not organized"
            })
            
        return actions
    
    def check_if_server_running(self):
        """Check if development server is running on port 3012"""
        try:
            result = subprocess.run(["lsof", "-i", ":3012"], 
                                 capture_output=True, text=True, timeout=5)
            return len(result.stdout.strip()) > 0
        except:
            return False
    
    def get_node_version(self):
        """Get Node.js version"""
        try:
            result = subprocess.run(["node", "--version"], 
                                 capture_output=True, text=True, timeout=5)
            return result.stdout.strip() if result.returncode == 0 else "Not found"
        except:
            return "Not found"
    
    def check_command_available(self, command):
        """Check if command is available"""
        try:
            result = subprocess.run(["which", command], 
                                 capture_output=True, text=True, timeout=5)
            return result.returncode == 0
        except:
            return False
    
    def get_git_status(self):
        """Get git repository status"""
        try:
            os.chdir(self.project_root)
            result = subprocess.run(["git", "status", "--porcelain"], 
                                 capture_output=True, text=True, timeout=5)
            if result.returncode == 0:
                changes = len(result.stdout.strip().split('\n')) if result.stdout.strip() else 0
                return {"changes": changes, "clean": changes == 0}
            else:
                return {"error": "Not a git repository"}
        except:
            return {"error": "Git not available"}
    
    def check_scripts_executable(self):
        """Check if project scripts are executable"""
        scripts = [
            "start-zone.sh",
            "analyze-docs.sh", 
            "maintain-docs.sh"
        ]
        
        executable_status = {}
        for script in scripts:
            script_path = self.project_root / script
            executable_status[script] = {
                "exists": script_path.exists(),
                "executable": script_path.exists() and os.access(script_path, os.X_OK)
            }
            
        return executable_status
    
    def get_last_modified(self, path):
        """Get last modified time of directory"""
        try:
            if path.exists():
                mtime = path.stat().st_mtime
                return datetime.fromtimestamp(mtime).strftime("%Y-%m-%d %H:%M")
            else:
                return "Never"
        except:
            return "Unknown"
    
    def display_dashboard(self):
        """Display formatted dashboard"""
        status = self.get_project_status()
        
        print("🎭 EventsOS Project Dashboard")
        print("=" * 50)
        print(f"📅 Last Updated: {status['timestamp']}")
        print()
        
        # Zone Template Status
        print("🏗️ Zone Template Status")
        print("-" * 25)
        zone = status['zone_template']
        print(f"✅ Template Directory: {'✓' if zone['exists'] else '✗'}")
        print(f"📦 Package.json: {'✓' if zone['has_package_json'] else '✗'}")
        print(f"📁 Dependencies: {'✓' if zone['has_node_modules'] else '✗'}")
        print(f"🌐 Server Running: {'✓' if zone['server_running'] else '✗'}")
        print(f"🕒 Last Modified: {zone['last_modified']}")
        
        if zone['ready_to_run']:
            print(f"🚀 Ready to Start: {zone['start_command']}")
        elif 'issues' in zone:
            print("⚠️ Issues:")
            for issue in zone['issues']:
                print(f"   - {issue}")
        print()
        
        # Documentation Status
        print("📚 Documentation Status")
        print("-" * 25)
        docs = status['documentation']
        print(f"📋 Master Index: {'✓' if docs['master_index'] else '✗'}")
        print(f"🚀 Quick Start Guide: {'✓' if docs['quick_start'] else '✗'}")
        print(f"🗺️ Zone Adaptation: {'✓' if docs['zone_adaptation'] else '✗'}")
        print(f"📄 Total Documents: {docs['total_docs']}")
        print(f"🕒 Last Updated: {docs['last_updated']}")
        print()
        
        # Development Environment
        print("💻 Development Environment")
        print("-" * 30)
        dev = status['development']
        print(f"📦 Node.js: {dev['node_version']}")
        print(f"📦 NPM Available: {'✓' if dev['npm_available'] else '✗'}")
        
        if 'error' not in dev['git_status']:
            git = dev['git_status']
            print(f"📚 Git Status: {git['changes']} changes {'(clean)' if git['clean'] else '(uncommitted)'}")
        else:
            print(f"📚 Git Status: {dev['git_status']['error']}")
        print()
        
        # Next Actions
        print("🎯 Next Actions")
        print("-" * 15)
        for i, action in enumerate(status['next_actions'], 1):
            priority_emoji = {"HIGH": "🔴", "MEDIUM": "🟡", "LOW": "🟢"}
            emoji = priority_emoji.get(action['priority'], "⚪")
            print(f"{emoji} {i}. {action['action']}")
            print(f"   💻 Command: {action['command']}")
            print(f"   📝 Reason: {action['description']}")
            print()
        
        # Quick Commands
        print("⚡ Quick Commands")
        print("-" * 16)
        print("🚀 Start Zone Template:")
        print("   ./start-zone.sh")
        print()
        print("📖 Open Documentation:")
        print(f"   open {self.docs_dir}/README.md")
        print()
        print("🔍 Check Project Status:")
        print("   python3 project-status.py")
        print()
        
    def run_quick_fix(self):
        """Run quick fixes for common issues"""
        print("🔧 Running Quick Fixes...")
        
        # Make scripts executable
        scripts = ["start-zone.sh", "analyze-docs.sh", "maintain-docs.sh"]
        for script in scripts:
            script_path = self.project_root / script
            if script_path.exists():
                os.chmod(script_path, 0o755)
                print(f"✅ Made {script} executable")
        
        # Create docs directory if needed
        if not self.docs_dir.exists():
            self.docs_dir.mkdir(parents=True)
            print("✅ Created docs directory")
            
        # Copy organized docs if they exist
        organized_docs = self.project_root / "docs-organized"
        if organized_docs.exists() and not (self.docs_dir / "README.md").exists():
            subprocess.run(["cp", "-r", str(organized_docs) + "/.", str(self.docs_dir)])
            print("✅ Copied organized documentation")
        
        print("🎉 Quick fixes completed!")

def main():
    dashboard = EventsOSDashboard()
    
    if len(os.sys.argv) > 1 and os.sys.argv[1] == "--fix":
        dashboard.run_quick_fix()
    else:
        dashboard.display_dashboard()
        
    # Check if we should show URL
    if dashboard.check_if_server_running():
        print("\n🌐 Development server is running!")
        print("   Visit: http://localhost:3012/travel")
        print("   Stop with: Ctrl+C in the terminal running the server")

if __name__ == "__main__":
    main()
