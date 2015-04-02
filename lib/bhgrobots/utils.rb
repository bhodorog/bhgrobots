require_relative "commands"

module Bhgrobots
  def self.klassify(inst)
    klass_name = inst[0].downcase.capitalize
    Object::const_get("Bhgrobots::#{klass_name}")
  end
  def self.build_cmd(inst)
    extra = inst[1, inst.length-1]
    self.klassify(inst).new(extra)
  end
end
