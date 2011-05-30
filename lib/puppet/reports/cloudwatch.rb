require 'puppet'
require 'yaml'

begin
  require 'fog'
rescue LoadError => e
  Puppet.info "You need the `fog` gem to use the CloudWatch report"
end

Puppet::Reports.register_report(:cloudwatch) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "cloudwatch.yaml"])
  raise(Puppet::ParseError, "CloudWatch report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  ACCESS_KEY_ID = config[:access_key_id]
  SECRET_ACCESS_KEY = config[:secret_access_key]

  desc <<-DESC
  Send notification of failed reports to AWS CloudWatch.
  DESC

  def process
    Puppet.debug "Sending status for #{self.host} to AWS CloudWatch"
    self.metrics.each { |metric,data|
      data.values.each { |val| 
        name = "Puppet #{val[1]} #{metric}"
        if metric == 'time'
          unit = 'Seconds'
        else
          unit = 'Count'
        end
        value = val[2]
        opts = {}
        opts = {:metric_name => name, :namespace => 'Puppet', :value => value, :unit => unit, :dimensions => [{'Name' => 'Hostname', 'Value' => self.host}]}
        @cw = Fog::AWS::CloudWatch.new(:aws_access_key_id => ACCESS_KEY_ID, :aws_secret_access_key => SECRET_ACCESS_KEY)
        @cw.metric_statistics.create(opts)
      }
    }
  end
end
