import { defineConfig } from 'vitepress'
import { withMermaid } from 'vitepress-plugin-mermaid'
import { fileURLToPath } from 'url'
import { dirname, resolve } from 'path'

const __dirname = dirname(fileURLToPath(import.meta.url))
const rootPath = resolve(__dirname, '../..')

export default withMermaid(
  defineConfig({
    title: 'Unified AI Platform',
    description: 'A comprehensive, self-hosted AI platform with OpenWebUI and LiteLLM',
    outDir: '../dist',
    base: '',
    cleanUrls: true,
    markdown: {
      anchor: {
        permalink: true,
        slugify: (str) => str
          .toLowerCase()
          .replace(/\s+/g, '-')
          .replace(/[^\w\-]+/g, '')
          .replace(/\-\-+/g, '-')
          .replace(/^-+/, '')
          .replace(/-+$/, '')
      },
      config: (md) => {
        // Additional markdown configuration if needed
      }
    },
    vite: {
      resolve: {
        alias: [
          {
            find: /^\/memory-bank\/(.*)/,
            replacement: resolve(rootPath, 'memory-bank/$1')
          }
        ]
      }
    },
    // Handle files outside of docs directory
    rewrites: {
      '/memory-bank/:path*': '/:path*'
    },
    themeConfig: {
      sidebar: [
        {
          text: 'Guide',
          items: [
            { text: 'Introduction', link: '/' },
            { text: 'OpenWebUI Configuration', link: '/openwebui-configuration' },
            { text: 'Railway Deployment Guide', link: '/railway-deployment-guide' },
            { text: 'Unified Platform Architecture', link: '/unified-platform-architecture' }
          ]
        },
        {
          text: 'Memory Bank',
          items: [
            { text: 'Project Brief', link: '/memory-bank/projectbrief' },
            { text: 'Product Context', link: '/memory-bank/productContext' },
            { text: 'System Patterns', link: '/memory-bank/systemPatterns' },
            { text: 'Technical Context', link: '/memory-bank/techContext' },
            { text: 'Active Context', link: '/memory-bank/activeContext' },
            { text: 'Progress', link: '/memory-bank/progress' }
          ]
        }
      ],
      socialLinks: [
        { icon: 'github', link: 'https://github.com/yourusername/unified-ai-platform' }
      ]
    },
    mermaid: {
      // Mermaid config options
      theme: 'default'
    }
  })
) 