require 'chefspec'
require 'chefspec/berkshelf'

describe 'mesos::install on systemd' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04'
    ) do |node|
      node.set['mesos']['init'] = 'systemd'
    end.converge('mesos::install')
  end

  it 'creates systemd units' do
    ['master', 'slave'].each do |comp|
      expect(chef_run).to create_template("mesos-#{comp}-init").with(
        path: "/etc/systemd/system/mesos-#{comp}.service"
      )
    end
  end
end
