#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

/**
 * Script to automatically update claude.md with current project information
 */

class ClaudeMdUpdater {
  constructor() {
    this.claudeMdPath = path.join(process.cwd(), 'claude.md');
    this.packageJsonPath = path.join(process.cwd(), 'package.json');
    this.tsconfigPath = path.join(process.cwd(), 'tsconfig.json');
  }

  readFile(filePath) {
    try {
      return fs.readFileSync(filePath, 'utf8');
    } catch (error) {
      console.error(`Error reading ${filePath}:`, error.message);
      return null;
    }
  }

  writeFile(filePath, content) {
    try {
      fs.writeFileSync(filePath, content);
      console.log(`✅ Updated ${filePath}`);
    } catch (error) {
      console.error(`Error writing ${filePath}:`, error.message);
    }
  }

  updatePackageVersions() {
    const packageJson = JSON.parse(this.readFile(this.packageJsonPath));
    let claudeMd = this.readFile(this.claudeMdPath);

    if (!packageJson || !claudeMd) return;

    const dependencies = {
      ...packageJson.dependencies,
      ...packageJson.devDependencies
    };

    // Update versions in the tech stack table
    const versionMappings = [
      { name: 'Next.js', key: 'next' },
      { name: 'React', key: 'react' },
      { name: 'TypeScript', key: 'typescript' },
      { name: 'CopilotKit', key: '@copilotkit/react-core' },
      { name: 'Tailwind CSS', key: 'tailwindcss' },
      { name: 'React Hook Form', key: 'react-hook-form' },
      { name: 'Zod', key: 'zod' }
    ];

    versionMappings.forEach(({ name, key }) => {
      if (dependencies[key]) {
        const version = dependencies[key].replace(/[\^~]/, '');
        const regex = new RegExp(`(${name} \\| )[^|]+(\\|)`, 'g');
        claudeMd = claudeMd.replace(regex, `$1${version} $2`);
      }
    });

    return claudeMd;
  }

  updateFileStructure() {
    let claudeMd = this.readFile(this.claudeMdPath);
    if (!claudeMd) return claudeMd;

    try {
      // Generate file tree (excluding common directories)
      const tree = execSync(
        'tree -I "node_modules|.git|.next|coverage|dist|.turbo" --dirsfirst -a -L 3',
        { encoding: 'utf8' }
      );

      // Find and replace the file structure section
      const startMarker = '```\ncopilot-form-filling/';
      const endMarker = '```\n\n## Conventions';
      
      const startIndex = claudeMd.indexOf(startMarker);
      const endIndex = claudeMd.indexOf(endMarker, startIndex);

      if (startIndex !== -1 && endIndex !== -1) {
        claudeMd = 
          claudeMd.substring(0, startIndex) +
          '```\n' + tree + '```\n\n## Conventions' +
          claudeMd.substring(endIndex + endMarker.length);
      }
    } catch (error) {
      console.warn('⚠️  Could not update file structure (tree command may not be available)');
    }

    return claudeMd;
  }

  updateCommands() {
    const packageJson = JSON.parse(this.readFile(this.packageJsonPath));
    let claudeMd = this.readFile(this.claudeMdPath);

    if (!packageJson || !claudeMd) return claudeMd;

    const scripts = packageJson.scripts || {};
    
    // Build commands sections
    let devCommands = '### Development\n```bash\n';
    let buildCommands = '### Build & Production\n```bash\n';
    let testCommands = '### Testing\n```bash\n';

    // Categorize scripts
    Object.entries(scripts).forEach(([name, command]) => {
      const comment = this.getScriptComment(name);
      
      if (['dev', 'start'].includes(name)) {
        devCommands += `${comment}\nnpm run ${name}\n\n`;
      } else if (['build', 'analyze'].includes(name)) {
        buildCommands += `${comment}\nnpm run ${name}\n\n`;
      } else if (name.includes('test')) {
        testCommands += `${comment}\nnpm run ${name}\n\n`;
      } else if (['lint', 'type-check', 'format'].includes(name)) {
        devCommands += `${comment}\nnpm run ${name}\n\n`;
      }
    });

    devCommands = devCommands.trim() + '\n```';
    buildCommands = buildCommands.trim() + '\n```';
    testCommands = testCommands.trim() + '\n```';

    // Replace commands section
    const commandsStart = claudeMd.indexOf('## Commands');
    const assistantStart = claudeMd.indexOf('## Assistant Instructions');
    
    if (commandsStart !== -1 && assistantStart !== -1) {
      claudeMd = 
        claudeMd.substring(0, commandsStart) +
        '## Commands\n\n' +
        devCommands + '\n\n' +
        buildCommands + '\n\n' +
        testCommands + '\n\n' +
        claudeMd.substring(assistantStart);
    }

    return claudeMd;
  }

  getScriptComment(scriptName) {
    const comments = {
      'dev': '# Start development server',
      'build': '# Build for production',
      'start': '# Start production server',
      'lint': '# Run ESLint',
      'type-check': '# Check TypeScript types',
      'format': '# Format code with Prettier',
      'test': '# Run unit tests',
      'test:e2e': '# Run end-to-end tests',
      'analyze': '# Analyze bundle size'
    };

    return comments[scriptName] || `# Run ${scriptName}`;
  }

  updateTimestamp(content) {
    const timestamp = new Date().toISOString();
    return content.replace(
      /\*\*Last Updated\*\*:.*/,
      `**Last Updated**: ${timestamp}`
    );
  }

  async run() {
    console.log('🔄 Updating claude.md...\n');

    let content = this.readFile(this.claudeMdPath);
    if (!content) {
      console.error('❌ claude.md not found');
      return;
    }

    // Run all updates
    content = this.updatePackageVersions();
    content = this.updateFileStructure() || content;
    content = this.updateCommands() || content;
    content = this.updateTimestamp(content);

    // Write updated content
    this.writeFile(this.claudeMdPath, content);

    console.log('\n✨ claude.md update complete!');
  }
}

// Run if called directly
if (require.main === module) {
  const updater = new ClaudeMdUpdater();
  updater.run();
}

module.exports = ClaudeMdUpdater;