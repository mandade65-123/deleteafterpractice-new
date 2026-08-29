#for aws installation
#apt install unzip -y
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#identity
aws sts get-caller-identity

#Connect to Your Jenkins Server
ssh user@your-jenkins-server-ip

#for eks cluster steps
 #Install eksctl
 # 1. Download and extract the latest Linux AMD64 binary into /tmp
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# 2. Move the binary into your global binary folder
sudo mv /tmp/eksctl /usr/local/bin

# 3. Verify the installation
eksctl version


#Install kubectl
# 1. Download the latest stable native Linux binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# 2. Install it with execution permissions to /usr/local/bin
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 3. Verify the installation
kubectl version --client


# Test permissions as the jenkins system user
sudo -u jenkins eksctl version
sudo -u jenkins kubectl version --client


#for forget the jenkins password
sudo systemctl stop jenkins
#open /var/lib/jenkins/config.xml
vim config.xml
<useSecurity>false</useSecurity>
sudo systemctl restart jenkins

