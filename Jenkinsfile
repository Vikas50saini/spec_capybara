pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup') {
            environment {
                RUBY_VERSION = '3.1.2'
                HEADLESS_MODE = 'true'
            }
            steps {
                script {
                    // Use Ruby version
                    sh "rvm install ${RUBY_VERSION}"
                    sh "rvm use ${RUBY_VERSION} --default"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install gem dependencies
                sh 'bundle install'
            }
        }

        stage('Run Tests') {
            steps {
                // Run headless tests with parallel execution
                sh 'HEADLESS_MODE=true bundle exec parallel_rspec spec/* -n 4'
            }
        }

        stage('Generate HTML report') {
            steps {
                // Assuming `merge_reports.rb` script is present in the repository
                sh 'ruby merge_reports.rb' // Script to combine reports (if needed)
            }
        }
    }

    post {
        always {
            // Archive test results and any other reports you need
            archiveArtifacts artifacts: '**/merged_report.html', allowEmptyArchive: true
        }
        cleanup {
            // Clean up the workspace
            cleanWs()
        }
    }
}
