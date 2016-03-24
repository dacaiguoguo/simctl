require 'simctl/object'
require 'timeout'

module SimCtl
  class Device < Object
    attr_reader :availability, :name, :os, :state, :udid

    def boot!
      SimCtl.boot_device(self)
    end

    def delete!
      SimCtl.delete_device(self)
    end

    def erase!
      SimCtl.erase_device(self)
    end

    def kill!
      SimCtl.kill_device(self)
    end

    def launch!
      SimCtl.launch_device(self)
    end

    def rename!(name)
      SimCtl.rename_device(self, name)
    end

    def shutdown!
      SimCtl.shutdown_device(self)
    end

    def state
      @state.downcase.to_sym
    end

    def wait!(timeout=15)
      Timeout::timeout(timeout) do
        loop do
          break if yield SimCtl.device(udid: udid)
        end
      end
    end

    def ==(other)
      other.udid == udid
    end

  end
end
