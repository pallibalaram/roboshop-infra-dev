pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
    options {
        ansiColor('xterm')
        // timeout(time: 1, unit: 'HOURS')
        // disableConcurrentBuilds()
    }

    // build
    stages {
        stage('VPC') {
            steps {
                sh """
                    cd 01-vpc
                    terraform init -reconfigure
                    terraform apply -auto-appprove
                """
            }
        }
        stage('SG') {
            steps {
                sh """
                    cd 02-sg
                    terraform init -reconfigure
                    terraform apply -auto-appprove
                """
            }
        }
        stage('VPN') {
            steps {
                sh """
                    cd 03-vpn
                    terraform init -reconfigure
                    terraform apply -auto-appprove
                """
            }
        }
        stage('DB ALB') {
            parallel {
                stage('DB') {
                    steps {
                        sh """
                            cd 04-databases
                            terraform init -reconfigure
                            terraform apply -auto-appprove
                        """
                    }
                }
                stage('APP ALB') {
                    steps {
                        sh """
                            cd 05-app-alb
                            terraform init -reconfigure
                            terraform apply -auto-appprove
                        """
                    }
                }
            }
        }
    }
    // post build
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
        failure { 
            echo 'this runs when pipeline is failed, used generally to send some alerts'
        }
        success{
            echo 'I will say Hello when pipeline is success'
        }
    }
}