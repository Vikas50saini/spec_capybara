pipeline {
    agent {
        docker {
            label 'Docker' // The label configured in the Docker template
            image 'ruby:3.1.2' // The Docker image to use
            args '-v /host/path/to/project:/project' // Optional: bind mount if needed
        }
    }

    environment {
        HEADLESS_MODE = 'true' // Environment variable for headless mode
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from your GitHub repository
                git url: 'https://github.com/your-username/your-repo.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install bundler and the project dependencies
                sh 'gem install bundler -v 2.3.4'
                sh 'bundle install'
            }
        }

        stage('Run Tests') {
            steps {
                // Execute the parallel RSpec tests
                sh 'bundle exec parallel_rspec spec/* -n 4'
            }
        }
    }

    post {
        always {
            // Archive test results and other artifacts if necessary
            archiveArtifacts artifacts: '**/log/*.log', allowEmptyArchive: true
            junit '**/reports/**/*.xml'
        }

        success {
            // Notify success (e.g., via email or Slack)
            echo 'Tests passed successfully!'
        }

        failure {
            // Notify failure (e.g., via email or Slack)
            echo 'Tests failed.'
        }
    }
}
