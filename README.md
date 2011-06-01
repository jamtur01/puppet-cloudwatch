puppet-cloudwatch
=================

Description
-----------

A Puppet report processor for sending metrics to [Amazon CloudWatch](http://aws.amazon.com/cloudwatch/).

Requirements
------------

* `fog` gem
* `Puppet`
* An Amazon CloudWatch account

Installation & Usage
--------------------

1.  Install the `fog` gem on your Puppet master

        $ sudo gem install fog

    Currently requires [this branch of
    Fog](https://github.com/fcheung/fog/tree/cloudwatch) that includes full
    support for the AWS CloudWatch API.

2.  Install puppet-cloudwatch as a module in your Puppet master's module
    path.

3.  Update the `aws_key_id` and `aws_secret_key` variables in the `cloudwatch.yaml` file with 
    your cloudwatch server IP and port and copy the file to `/etc/puppet/`. An example file is included.

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = cloudwatch
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

5.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
