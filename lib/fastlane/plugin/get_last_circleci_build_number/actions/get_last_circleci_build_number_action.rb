require 'fastlane/action'

module Fastlane
	module Actions
		module SharedValues
      GET_LAST_CIRCLECI_BUILD_NUMBER = :GET_LAST_CIRCLECI_BUILD_NUMBER
		end

    class GetLastCircleciBuildNumberAction < Action
      def self.run(params)
        Actions.verify_gem!('circleci')
        require 'circleci'
        configure(params)
        get
			end

			def self.token(params)
        token = params[:api_token].nil? ? ENV['CIRCLECI_TOKEN'] : params[:api_token]
        CircleCi.configure do |config|
          config.token = token
        end
        token
			end

			def self.configure(params)
        @token = params[:api_token].nil? ? ENV['CIRCLECI_TOKEN'] : params[:api_token]
        @user = params[:user_name].nil? ? ENV['CIRCLECI_USER_NAME'] : params[:user_name]
        @repository = params[:repository].nil? ? ENV['CIRCLECI_REPOSITORY'] : params[:repository]

        CircleCi.configure do |config|
          config.token = @token
        end

        UI.user_error! "Set CIRCLECI_TOKEN" if @token.nil? || @token.empty?
        UI.user_error! "Set CIRCLECI_USER_NAME" if @user.nil? || @user.empty?
        UI.user_error! "Set CIRCLECI_REPOSITORY" if @repository.nil? || @repository.empty?
        UI.message "Access to #{@user}/#{@repository}"
			end

			def self.get
        project = CircleCi::Project.new @user, @repository
        res = project.recent_builds limit: 1
        build_num = res.body.map do |e|
          e['build_num']
        end

        Actions.lane_context[SharedValues::GET_LAST_CIRCLECI_BUILD_NUMBER] = build_num[0]
      end

      def self.description
        "fetches the last build number from circleci."
      end

      def self.authors
        ["Dawid van der Hoven"]
      end

      def self.output
        [
          ['LAST_CIRCLE_CI_BUILD_NUMBER', 'Last Build Number']
        ]
      end

      def self.details
        "Fetches that last build number from circleci using the circleci gem, useful for local builds when the project uses the circleci build number as the version build number."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                  env_name: "CIRCLECI_TOKEN",
                               description: "API Token for Circle CI",
                                      type: String,
                                  optional: true),
          FastlaneCore::ConfigItem.new(key: :user_name,
                                  env_name: "CIRCLECI_USER_NAME",
                               description: "user name for Circle CI",
                                      type: String,
                                  optional: true),
          FastlaneCore::ConfigItem.new(key: :repository,
                                  env_name: "CIRCLECI_REPOSITORY",
                               description: "repository for Circle CI",
                                      type: String,
                                  optional: true)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :android].include?(platform)
      end
    end
  end
end
