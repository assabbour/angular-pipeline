pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_credentials') // Docker Hub credentials
        DOCKER_IMAGE = "assabbour/angular-app:latest" // Nom de l'image Docker
    }

    stages {
        stage('Cloner le dépôt') {
            steps {
                script {
                    echo "Étape : Cloner le dépôt démarrée."
                    git branch: 'main', url: 'https://github.com/assabbour/angular-pipeline.git'
                    echo "Étape : Cloner le dépôt terminée avec succès."
                }
            }
        }

        stage('Installer les dépendances') {
            steps {
                script {
                    echo "Étape : Installer les dépendances démarrée."
                    sh 'npm install'
                    echo "Étape : Installer les dépendances terminée avec succès."
                }
            }
        }

        stage('Exécuter les tests') {
            steps {
                script {
                    echo "Étape : Exécuter les tests démarrée."
                    sh '''
                    npm test -- --watch=false --browsers=ChromeHeadless || {
                        echo "Tests échoués. Abandon du pipeline."
                        exit 1
                    }
                    '''
                    echo "Étape : Exécuter les tests terminée avec succès."
                }
            }
        }

        stage('Construire l\'image Docker') {
            steps {
                script {
                    echo "Étape : Construire l'image Docker démarrée."
                    sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker build -t $DOCKER_IMAGE .
                    '''
                    echo "Étape : Construire l'image Docker terminée avec succès."
                }
            }
        }

        stage('Pousser l\'image sur Docker Hub') {
            steps {
                script {
                    echo "Étape : Pousser l'image sur Docker Hub démarrée."
                    sh '''
                    docker push $DOCKER_IMAGE
                    '''
                    echo "Étape : Pousser l'image sur Docker Hub terminée avec succès."
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé."
            sh 'docker logout' // Déconnexion de Docker Hub
        }
        failure {
            echo "Le pipeline a échoué. Vérifiez les étapes précédentes."
        }
        success {
            echo "Le pipeline a réussi avec succès."
        }
    }
}
