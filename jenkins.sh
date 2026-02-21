#!/bin/bash
curl -Lo /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
dnf install jenkins -y
dnf install java-21-openjdk-headless -y
dnf install fontconfig dejavu-sans-fonts -y
systemctl daemon-reload
systemctl enable jenkins    
systemctl start jenkins