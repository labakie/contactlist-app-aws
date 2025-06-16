# ContactList Web App in AWS

### 📐 Architecture Diagram

<img src="https://github.com/user-attachments/assets/76f8d13e-3b48-484a-844c-9b25b6efda02" width="800"/>

### 📌 Overview
This repository contains the Terraform infrastructure code to deploy a simple CRUD web application for managing a contact list, built with Python Flask.

Currently, the web application code is hosted in a private GitHub repository and is cloned to the EC2 instance using a GitHub Personal Access Token stored securely in AWS Systems Manager Parameter Store.

The main goal of this project is to deepen my understanding of AWS services, especially EC2 as IaaS and IAM roles & security best practices.  
All infrastructure is provisioned and managed using Terraform, including DNS A records created via the Cloudflare Terraform provider, which maps the EC2 instance's public IPv4 address to my custom domain: [contact.zaril.my.id](https://contact.zaril.my.id).

The web application is currently inactive to avoid unnecessary costs, but the entire infrastructure can be spun up at any time.

### 🗂️ Web Application Highlights

- Perform create, read, update, and delete operations on contacts.
- Each action is controlled by fine-grained AWS IAM Roles (CRUD separated by roles).
- Uses secure temporary credentials via AWS STS:AssumeRole, assumed by the EC2 instance at runtime.

### 🔑 Role-Based Access

This project demonstrates how to use AWS STS:AssumeRole with External ID to securely separate user permissions.  
Each role has its own IAM policy and can be tested by specifying different `role=` and `extid=` query parameters in the URL.  
Example usage for each role:

1. **Read Only**: `https://contact.zaril.my.id/?role=viewer&extid=readonly-123`  
2. **Update User**: `https://contact.zaril.my.id/?role=updateuser&extid=update-234`  
3. **Add-Delete User**: `https://contact.zaril.my.id/?role=adddeleteuser&extid=adddelete-345`  
4. **Admin**: `https://contact.zaril.my.id/?role=admin&extid=admin-456`

Accessing the app with no parameters, the wrong role, or an incorrect external ID will result in a blank page and an appropriate error message.

#### ❌ Error Page (No Parameter)

<img src="https://github.com/user-attachments/assets/aced90bc-ebeb-46ed-9162-3c2d05566473" alt="Error Page" width="700"/>

#### ✅ Admin Page

<img src="https://github.com/user-attachments/assets/0c7dc5ce-d174-4b0e-b348-0ff33fe07d6e" alt="Admin Page" width="700"/>

### ⚙️ Services Used

- **AWS EC2** — runs the Flask web app and uses a base IAM role to assume other roles dynamically.
- **AWS DynamoDB** — stores contact records (email, name, phone number).
- **AWS IAM Policies & Roles** — secure role-based access from EC2 to the DynamoDB table.
- **AWS Systems Manager Parameter Store** — securely stores a GitHub Personal Access Token to clone the private repository.
- **Cloudflare** — manages DNS A records to map the EC2 public IP to a domain name.
- **Nginx** — acts as an HTTPS reverse proxy for the Flask web app.
- **OpenSSL** — generates a self-signed SSL/TLS certificate for HTTPS.
