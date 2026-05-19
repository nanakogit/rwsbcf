⚠️ License & Copyright
This project is distributed under the CC BY-NC 4.0 license.
Whether you fork directly, modify the source code, or redistribute, you must retain the original author's attribution. Commercial profit-making actions are strictly prohibited. The author reserves the right to pursue legal liability for any infringement. (Sharing on video platforms like YouTube is supported, but you must provide the link to the original project).

# 🚀 High-Speed Proxy Node Deployment Guide (Sing-box + Cloudflare Tunnel)

This project provides a lightweight, highly stealthy proxy node deployment solution based on Docker containers. By integrating `sing-box` and `cloudflared`, you can easily build a secure tunnel with a single click on various cloud platforms (such as Koyeb, Render, etc.) or personal VPS instances.

## ✨ Core Features

* **Lightweight & Efficient**: Built on Alpine Linux and Docker, ensuring extremely low resource usage.
* **High Anonymity**: Leverages Cloudflare Tunnel to penetrate networks and hide your server's real IP, effectively preventing blocking.
* **Advanced Protocol**: Powered by `sing-box`, the most capable core currently available, with VLESS configured as the default protocol.
* **Automated Builds**: Pre-configured with GitHub Actions to automatically package and push Docker images to GitHub Packages (`ghcr.io`) upon code changes.
* **Flexible Configuration**: Dynamically inject UUID and Token via environment variables without modifying any source code.

## 📦 Project Structure

* `Dockerfile`: Configuration to automatically pull and build the required components into a Docker image.
* `config.json`: The core routing and protocol configuration file for `sing-box`.
* `start.sh`: Container startup script responsible for replacing environment variables and running dual processes simultaneously.

---

## 🛠️ Deployment Tutorial

This project can be deployed in any Docker-compatible environment. The following guide uses common cloud PaaS platforms as an example.

### Prerequisites

1.  **Cloudflare Tunnel**:
    * Log in to your [Cloudflare Zero Trust](https://dash.teams.cloudflare.com/) dashboard.
    * Navigate to **Networks** -> **Tunnels** and create a new Tunnel.
    * Save the generated **Tunnel Token** (referred to as `ARGO_TOKEN`).
    * Configure a Public Hostname for the tunnel (e.g., `proxy.yourdomain.com`) and point the service to `http://localhost:8080`.

2.  **Generate a UUID**:
    * Use an online tool or command line (like `uuidgen`) to generate a standard format UUID (e.g., `123e4567-e89b-12d3-a456-426614174000`).

### Starting Deployment

When creating a new application on your deployment platform (such as Koyeb), ensure you set the following **Environment Variables**:


| Variable Name | Description | Example |
| :--- | :--- | :--- |
| `UUID` | Your node connection password | `Your random UUID` |
| `ARGO_TOKEN` | Cloudflare Tunnel Token | `eyJh...` |

UUID Generator [Click to Generate](https://99688988.xyz/uuid-generator/)

*(Note: The default deployment port is `8080` and does not need to be changed)*

### Client Connection

After a successful deployment, add the following node details to your proxy client (such as v2rayN, Clash, etc.):

* **Address**: The Public Hostname you set in Cloudflare (e.g., `proxy.yourdomain.com`)
* **Port**: `443`
* **User ID (UUID)**: Your configured `$UUID`
* **Network**: `ws` (WebSocket)
* **SNI**: Your Public Hostname
* **TLS**: Enabled (`tls`)

Quick Share Link (URI Format) Example:

If you prefer to construct the link manually, it should follow this format (replace the bracketed text with your actual details):
`vless://[YOUR_UUID]@[YOUR_TUNNEL_DOMAIN_OR_OPTIMIZED_IP]:443?encryption=none&security=tls&sni=[YOUR_TUNNEL_DOMAIN]&insecure=0&allowInsecure=0&type=ws&host=[YOUR_TUNNEL_DOMAIN]&path=%2Fvless#Railway-Singbox`

If the speed is too slow, you can replace the **Address** with an optimized Cloudflare IP/Domain [Click to Get Optimized IPs](https://kjgx668.blogspot.com/2023/08/cloudflare-ip-cloudflare-cf.html)

---

## Advanced: Unlocking Streaming & Reducing Risk Profiles

If your node IP triggers high risk-scoring fraud blocks or cannot access services like ChatGPT/Netflix, you can integrate Cloudflare WARP outbound routing by modifying `config.json`.

How-to: Use WGCF to extract the WARP `PrivateKey` and `Address` (IPv4). Insert these details into the `outbounds` -> `warp` tag within `config.json`. The system will then automatically route your streaming media traffic through clean WARP nodes. Refer to the [Configuration Guide](#) for detailed steps.

---
> **Disclaimer**: This project is intended solely for learning and research purposes regarding network protocols. Please use it in strict compliance with your local laws and regulations.
>
> ⚠️ License & Copyright
This project is distributed under the CC BY-NC 4.0 license.
Whether you fork directly, modify the source code, or redistribute, you must retain the original author's attribution. Commercial profit-making actions are strictly prohibited. The author reserves the right to pursue legal liability for any infringement.
