# Linux Infrastructure: Game Server Deployment & Security
*A hands-on project focused on configuring a secure, high-performance Linux environment for Java-based applications.*

## 🚀 Overview
This project demonstrates the setup and maintenance of a persistent server instance on a Linux environment. The goal was to optimize system performance for concurrent users while maintaining a "security-first" network posture through proactive firewall management and automated system updates.

## 🛠️ Technical Implementation

### System Administration
* **Platform:** Linux (RHEL/CentOS/Ubuntu).
* **Environment:** Managed the latest Java Runtime Environment (JRE) to ensure compatibility and security for the application layer.
* **Maintenance:** Implemented a standard "update-first" protocol to ensure system packages and dependencies were current before deployment.

### Network Security & Configuration
To ensure external connectivity while protecting the host system, I configured specific zone-based firewall rules:
* **Ports:** Opened `25565/tcp` and `25565/udp` for application traffic.
* **Persistence:** Utilized `--permanent` flags to ensure network rules survived system reboots.
* **Command Workflow:**
  ```bash
  sudo firewall-cmd --permanent --zone=public --add-port=25565/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=25565/udp
  sudo firewall-cmd --reload
