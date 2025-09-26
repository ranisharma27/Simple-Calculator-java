pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-north-1'
        ECR_URI = '027557557213.dkr.ecr.eu-north-1.amazonaws.com/simple-calculator'
        IMAGE_TAG = '1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:ranisharma27/Simple-Calculator-java.git', credentialsId: 'github-ssh'
            }
        }

        stage('Build Java') {
            steps {
                sh 'javac Calculator.java'
                sh 'jar cfe Calculator.jar Calculator Calculator.class'
            }
        }

        stage('Build Docker') {
            steps {
                sh "docker build -t simple-calculator:${IMAGE_TAG} ."
            }
        }

        stage('Login to ECR') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: 'aws-credentials-id') {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URI}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker tag simple-calculator:${IMAGE_TAG} ${ECR_URI}:${IMAGE_TAG}"
                sh "docker push ${ECR_URI}:${IMAGE_TAG}"
            }
        }
    }

    post {
        success {
            echo 'Docker image pushed to ECR successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

