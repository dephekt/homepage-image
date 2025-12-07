# Media stack landing page

Minimal Hugo-based static site serving as a landing page for internal services and future technical blog content.

## Overview

This site provides:
- Landing page for friends and family to access internal services
- Privacy Policy and Terms of Service pages (Google OAuth compliance)
- `/apps` page - protected launcher for internal services (requires Keycloak auth)
- Blog structure for future technical content

## Architecture

The site is deployed as a Docker container and exposed through Pangolin:
- **Public access**: All pages are publicly accessible
- **Protected path**: `/apps` requires Keycloak SSO authentication (Member role)
- **Domain**: proxied through Pangolin edge nodes

## Local Development

### Prerequisites
- Hugo v0.146.0 or newer
- Git

### Running Locally

```bash
# Run the development server
hugo server -D

# Build the site
hugo --minify
```

The site will be available at `http://localhost:1313`

## Content Management

### Adding Blog Posts

1. Create a new markdown file in `content/posts/`:
   ```bash
   hugo new posts/my-new-post.md
   ```

2. Edit the front matter and content:
   ```markdown
   ---
   title: "My New Post"
   date: 2025-09-21
   draft: false  # Set to false when ready to publish
   tags: ["tag1", "tag2"]
   categories: ["Technical Guides"]
   ---

   Your content here...
   ```

3. Commit and push to deploy automatically:
   ```bash
   git add .
   git commit -m "Add new blog post: My New Post"
   git push
   ```

### Page Structure

- `content/_index.md` - Homepage content
- `content/privacy.md` - Privacy Policy
- `content/terms.md` - Terms of Service
- `content/posts/` - Blog posts directory
- `content/support/` - Support documentation and guides
  - `_index.md` - Support section landing page
  - `login.md` - Guide for logging into services

### DNS Configuration

Point your website CNAME to your Pangolin edge node domain, and configure the domain in Pangolin Cloud for automatic TLS certificate provisioning.

### Architecture

The homepage is built as a Docker container in the `core` project:
- Source: Git submodule at `core/tech-blog/`
- Dockerfile: `core/homepage.Dockerfile`
- Container: Nginx serving static Hugo build
- **Pangolin labels:**
  - Full domain: `www.${DOMAIN}`
  - Rule: `/apps` path requires SSO authentication (Member role)
  - All other paths are publicly accessible

## Theme

Using [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme for a clean, professional appearance.
