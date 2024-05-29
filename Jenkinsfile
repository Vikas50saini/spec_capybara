pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Tests in Docker') {
            agent {
                docker {
                    image 'ruby:3.1.2'
                }
            }
            stages {
                stage('Install Dependencies') {
                    steps {
                        sh 'gem install bundler -v 2.0.1'
                        sh 'bundle install'
                    }
                }

                stage('Run Tests') {
                    steps {
                        sh 'HEADLESS_MODE=true bundle exec parallel_rspec spec/* -n 4'
                    }
                }

                stage('Generate HTML report') {
                    steps {
                        sh 'ruby merge_reports.rb'
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/merged_report.html', allowEmptyArchive: true
        }
        cleanup {
            cleanWs()
        }
    }
}
