# OpenWebUI Configuration Guide

This document provides detailed configuration options for OpenWebUI as deployed in the Unified AI Platform.

## Essential Configuration

### API Connectivity

| Environment Variable | Description | Default | Example |
|---|---|---|---|
| `OPENAI_API_BASE_URL` | URL for LiteLLM API | None | `https://litellm-ruog-production.up.railway.app/v1` |
| `OPENAI_API_KEY` | Authentication key for LiteLLM | None | `sk-f16230c726f8913ac2016e5fc13867bc43c926fdeeccb8bd1010e21fe5e7e7e4` |

### Basic Settings

| Environment Variable | Description | Default | Example |
|---|---|---|---|
| `PORT` | Port to run OpenWebUI on | `8080` | `8080` |
| `WEBUI_NAME` | Name of the instance | `OpenWebUI` | `Unified AI Platform` |
| `WEBUI_SECRET_KEY` | Encryption key | None | `sk-a12a9f238de9663825c7c1ece9e16ee6e0462661fdafde2225ec3954153019af` |

### Authentication

| Environment Variable | Description | Default | Example |
|---|---|---|---|
| `WEBUI_AUTH` | Enable authentication | `false` | `true` |
| `ENABLE_SIGNUP` | Allow users to register | `false` | `true` |
| `ENABLE_LOGIN_FORM` | Show login form | `false` | `true` |
| `DEFAULT_USER_ROLE` | Role for new users | `user` | `admin` |

## Integration Modules

### Web Search Integration

| Environment Variable | Description | Default | Recommended Value |
|---|---|---|---|
| `ENABLE_RAG_WEB_SEARCH` | Enable web search | `false` | `true` |
| `RAG_WEB_SEARCH_ENGINE` | Web search provider | `google` | `searxng` |
| `SEARXNG_QUERY_URL` | URL for SearXNG | None | `https://searxng-production-4499.up.railway.app/search?q=<query>` |
| `RAG_WEB_SEARCH_RESULT_COUNT` | Number of results to return | `3` | `3` |

> **Important:** When using SearXNG, ensure that `RAG_WEB_SEARCH_ENGINE` is set to `searxng` and `SEARXNG_QUERY_URL` contains the `<query>` placeholder exactly as shown.

### Document Processing

| Environment Variable | Description | Default | Recommended Value |
|---|---|---|---|
| `CONTENT_EXTRACTION_ENGINE` | Document processing engine | None | `tika` |
| `TIKA_SERVER_URL` | URL for Apache Tika | None | `https://tika-production.up.railway.app` |
| `RAG_EMBEDDING_ENGINE` | Embedding model provider | None | `openai` |
| `RAG_EMBEDDING_MODEL` | Embedding model to use | None | `text-embedding-3-small` |
| `CHUNK_SIZE` | Size of text chunks | `1000` | `1000` |
| `CHUNK_OVERLAP` | Overlap between chunks | `100` | `100` |

### JupyterLab Integration

| Environment Variable | Description | Default | Recommended Value |
|---|---|---|---|
| `JUPYTER_SERVER_URL` | URL for JupyterLab | None | `https://jupyterlab-production-bbcb.up.railway.app` |
| `JUPYTER_PASSWORD` | Authentication for JupyterLab | None | Set to the same password as configured in JupyterLab |
| `ENABLE_CODE_EXECUTION` | Enable code execution | `false` | `true` |

> **Note:** JupyterLab uses password-based authentication in our setup, not token-based. Ensure that `JUPYTER_PASSWORD` in OpenWebUI matches the `JUPYTER_PASSWORD` set in the JupyterLab service.

## Advanced Configuration

### Performance Tuning

| Environment Variable | Description | Default | Recommended Value |
|---|---|---|---|
| `MAX_CONCURRENT_STREAMS` | Maximum concurrent streams | `5` | `5` |
| `WEBUI_TIMEOUT` | Timeout for API requests | `300` | `300` |

### Storage Settings

| Environment Variable | Description | Default | Recommended Value |
|---|---|---|---|
| `STORAGE_PATH` | Path for storage | `/app/backend/data` | Default |
| `DATABASE_URL` | Database connection string | None | None |

## Deployment-Specific Settings

When deployed on Railway, several environment variables are automatically set:

| Environment Variable | Description | Example |
|---|---|---|---|
| `RAILWAY_PUBLIC_DOMAIN` | Public domain for the service | `openwebui-production-f58b.up.railway.app` |
| `RAILWAY_PRIVATE_DOMAIN` | Private internal domain | `openwebui.railway.internal` |
| `RAILWAY_SERVICE_NAME` | Service name | `openwebui` |

## Troubleshooting

### Common Issues

1. **LiteLLM Connection Issues**
   - Verify `OPENAI_API_BASE_URL` points to the correct LiteLLM instance
   - Ensure `OPENAI_API_KEY` matches the `LITELLM_MASTER_KEY` in the LiteLLM service

2. **Web Search Not Working**
   - Confirm `RAG_WEB_SEARCH_ENGINE` is set to `searxng`
   - Verify the `SEARXNG_QUERY_URL` format is correct with `<query>` placeholder
   - Check that SearXNG service is running and accessible

3. **JupyterLab Integration Not Working**
   - Ensure `JUPYTER_SERVER_URL` points to the correct JupyterLab instance
   - Verify that `JUPYTER_PASSWORD` matches the password set in JupyterLab
   - Check `ENABLE_CODE_EXECUTION` is set to `true`
   - Verify JupyterLab is properly configured with password authentication 