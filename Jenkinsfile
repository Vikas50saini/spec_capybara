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
                    fi

                    # Source RVM scripts and reload shell environment
                    source ~/.rvm/scripts/rvm
                    '''

                    // Install specified Ruby version if not installed
                    sh "rvm install ${RVM_VERSION}"

                    // Use specified Ruby version
                    sh "rvm use ${RVM_VERSION} --default"
                }
                // Print Ruby and Bundler versions to verify setup
                sh 'ruby -v'
                sh 'gem install bundler -v 2.3.4'
                sh 'bundle -v'
            }
        }

        // Rest of your stages...
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
