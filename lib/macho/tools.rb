module MachO
  # A collection of convenient methods for common operations on Mach-O and Fat binaries.
  module Tools
    # @param filename [String] the Mach-O or Fat binary being read
    # @return [Array<String>] an array of all dylibs linked to the binary
    def self.dylibs(filename)
      file = MachO.open(filename)

      file.linked_dylibs
    end

    # Changes the dylib ID of a Mach-O or Fat binary, overwriting the source file.
    # @param filename [String] the Mach-O or Fat binary being modified
    # @param new_id [String] the new dylib ID for the binary
    # @return [void]
    def self.change_dylib_id(filename, new_id)
      file = MachO.open(filename)

      file.dylib_id = new_id
      file.write!
    end

    # Changes a shared library install name in a Mach-O or Fat binary, overwriting the source file.
    # @param filename [String] the Mach-O or Fat binary being modified
    # @param old_name [String] the old shared library name
    # @param new_name [String] the new shared library name
    # @return [void]
    def self.change_install_name(filename, old_name, new_name)
      file = MachO.open(filename)

      file.change_install_name(old_name, new_name)
      file.write!
    end

    # Changes a runtime path in a Mach-O or Fat binary, overwriting the source file.
    # @param filename [String] the Mach-O or Fat binary being modified
    # @param old_path [String] the old runtime path
    # @param new_path [String] the new runtime path
    # @return [void]
    def self.change_rpath(filename, old_path, new_path)
      file = MachO.open(filename)

      file.change_rpath(old_path, new_path)
      file.write!
    end

    # Add a runtime path to a Mach-O or Fat binary, overwriting the source file.
    # @param filename [String] the Mach-O or Fat binary being modified
    # @param new_path [String] the new runtime path
    # @return [void]
    # @todo unstub
    def self.add_rpath(filename, new_path)
      file = MachO.open(filename)

      file.add_rpath(new_path)
      file.write!
    end

    # Delete a runtime path from a Mach-O or Fat binary, overwriting the source file.
    # @param filename [String] the Mach-O or Fat binary being modified
    # @param old_path [String] the old runtime path
    # @return [void]
    def self.delete_rpath(filename, old_path)
      file = MachO.open(filename)

      file.delete_rpath(old_path)
      file.write!
    end
  end
end
