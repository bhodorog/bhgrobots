require_relative "commands"

module Bhgrobots
  def self.klassify(inst)
    raw_name, *_ = inst.split(" ")
    klass_name = raw_name.split(" ")[0].downcase.capitalize
    Object::const_get("Bhgrobots::#{klass_name}")
  end
  def self.build_cmd(inst)
    _, *extras = inst.split(" ")
    self.klassify(inst).new(extras)
  end
  def self.class_name(fqn)
    fqn.split("::")[-1]
  end
end
