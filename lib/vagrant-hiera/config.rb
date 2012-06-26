module VagrantHiera

  class Config < Vagrant::Config::Base
    attr_accessor :config_path
    attr_accessor :guest_config_path
    attr_accessor :config_file
    attr_accessor :data_path
    attr_accessor :guest_data_path

    def guest_config_path
      @guest_config_path.nil? ? (@guest_config_path = '/tmp/vagrant-hiera/config') : @guest_config_path
    end

    def guest_data_path
      @guest_data_path.nil? ? (@guest_data_path = '/tmp/vagrant-hiera/data') : @guest_data_path
    end

    def config_path
      File.expand_path(@config_path) rescue ''
    end

    def data_path
      File.expand_path(@data_path) rescue ''
    end

    def set?
      config_path || config_file || data_path
    end

    def validate(env, errors)
      errors.add("Config path can not be empty") if config_path.empty?
      errors.add("Config file can not be empty") if config_file.empty?
      errors.add("Data path can not be empty") if data_path.empty?
      config = File.join("#{config_path}", "#{config_file}")
      errors.add("#{config} does not exist.") unless File.exists?(config)
      errors.add("#{data_path} does not exist.") unless File.exists?("#{data_path}")
    end
  end
end
