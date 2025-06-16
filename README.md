# ContactList Web App in AWS
### Architecture Diagram
<img src="https://github.com/user-attachments/assets/76f8d13e-3b48-484a-844c-9b25b6efda02" width="800"/>

### Overview
This repository contains my project of the Terraform infrastructure code to deploy a simple CRUD web application for managing a contact list, created with Python Flask. Currently the web application code is placed in a private GitHub Repository and cloned using a GitHub Personal Access Token. The purpose of this project is to make me understand more about AWS services, especially EC2 as IaaS and also IAM to increase security. All services used are written in Terraform, including setting up DNS A records using Cloudflare provider. It will takes the newly created EC2 instance IPv4 address and map it to my domain, [contact.zaril.my.id](https://contact.zaril.my.id). The web application is currently inactive to prevent any costs, but this entire infrastructure can be spin up anytime.

**More details about the contact list web application:**
- Add, read, update, and delete contacts.
- Each action is restricted by AWS IAM Roles with fine-grained permissions (CRUD separated by IAM roles).
- Uses secure temporary credentials that EC2 instance assumed via AWS STS:AssumeRole.

**Role-Based Access:**

This project demonstrates how to use AWS STS:AssumeRole with External ID to securely separate role. Each role has its own policy and can be tested via different `role=` and `extid=` query parameters in the URL. For example, here are each role and its exact URL that need to be typed in order to enter the designated page: 

1. Read Only       = `https://contact.zaril.my.id/?role=viewer&extid=readonly-123`
2. Update User     = `https://contact.zaril.my.id/?role=updateuser&extid=update-234`
3. Add-Delete User = `https://contact.zaril.my.id/?role=adddeleteuser&extid=adddelete-345`
4. Admin           = `https://contact.zaril.my.id/?role=admin&extid=admin-456`

Typing only `https://contact.zaril.my.id`, wrong role parameter, or wrong External ID will only redirects to a blank page and its respective error message. 

### Services Used

- **AWS EC2** — runs the Flask web app and assumes roles using a base role.
- **AWS DynamoDB** — stores contact items (email, name, phone number).
- **AWS IAM Policies + Roles** — secure role-based access control for EC2 to accessing DynamoDB table.
- **AWS Systems Manager - Parameter Store** — stores a GitHub Personal Access Token to clone the web app code private repository.
- **Cloudflare** — creates A records to map EC2 IPv4 address to a domain name.
- **Nginx** — as HTTPS reverse proxy.
- **OpenSSL** — creates a self-signed SSL/TLS certificate for server.
