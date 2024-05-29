pipeline {
    agent any

    environment {
        RVM_VERSION = '3.1.2'
        HEADLESS_MODE = 'true'
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    // Install RVM and the specified Ruby version
                    sh '''
                    # Install RVM if not installed
                    if ! type rvm > /dev/null 2>&1; then
                        curl -sSL https://get.rvm.io | bash -s stable
                        source ~/.rvm/scripts/rvm
                    fi

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
