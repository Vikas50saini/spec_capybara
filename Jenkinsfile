pipeline {
    agent {
        docker {
            image 'ruby:3.1.2' // Use your custom Docker image with RVM installed
            args '-u root' // This is optional, to run Docker container as root
        }
    }

    environment {
        RVM_VERSION = '3.1.2'
        HEADLESS_MODE = 'true'
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    // Install the specified Ruby version
                    sh '''
                    # Install specified Ruby version if not installed
                    rvm list strings | grep -q ${RVM_VERSION} || rvm install ${RVM_VERSION}

                    # Use specified Ruby version
                    rvm use ${RVM_VERSION} --default
                    '''
                }
                // Print Ruby and Bundler versions to verify setup
                sh 'ruby -v'
                sh 'gem install bundler -v 2.3.4'
                sh 'bundle -v'
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
                // Run the test suite
                sh 'HEADLESS_MODE=true bundle exec parallel_rspec spec/* -n 4'
            }
        }
    }

    post {
        always {
            // Archive test results and any other reports you need
            archiveArtifacts artifacts: '**/spec/reports/*.html', allowEmptyArchive: true
            junit '**/spec/reports/*.xml'
        }
        cleanup {
            // Clean up the workspace
            cleanWs()
        }
    }
}
