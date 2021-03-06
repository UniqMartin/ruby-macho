module MachO
  # A generic Mach-O error in execution.
  class MachOError < RuntimeError
  end

  # Raised when a file is not a Mach-O.
  class NotAMachOError < MachOError
    # @param error [String] the error in question
    def initialize(error)
      super error
    end
  end

  # Raised when a file is too short to be a valid Mach-O file.
  class TruncatedFileError < NotAMachOError
    def initialize
      super "File is too short to be a valid Mach-O"
    end
  end

  # Raised when a file's magic bytes are not valid Mach-O magic.
  class MagicError < NotAMachOError
    # @param num [Fixnum] the unknown number
    def initialize(num)
      super "Unrecognized Mach-O magic: 0x#{"%02x" % num}"
    end
  end

  # Raised when a file is a Java classfile instead of a fat Mach-O.
  class JavaClassFileError < NotAMachOError
    def initialize
      super "File is a Java class file"
    end
  end

  # Raised when a fat binary is loaded with MachOFile.
  class FatBinaryError < MachOError
    def initialize
      super "Fat binaries must be loaded with MachO::FatFile"
    end
  end

  # Raised when a Mach-O is loaded with FatFile.
  class MachOBinaryError < MachOError
    def initialize
      super "Normal binaries must be loaded with MachO::MachOFile"
    end
  end

  # Raised when the CPU type is unknown.
  class CPUTypeError < MachOError
    # @param cputype [Fixnum] the unknown CPU type
    def initialize(cputype)
      super "Unrecognized CPU type: 0x#{"%08x" % cputype}"
    end
  end

  # Raised when the CPU type/sub-type pair is unknown.
  class CPUSubtypeError < MachOError
    # @param cputype [Fixnum] the CPU type of the unknown pair
    # @param cpusubtype [Fixnum] the CPU sub-type of the unknown pair
    def initialize(cputype, cpusubtype)
      super "Unrecognized CPU sub-type: 0x#{"%08x" % cpusubtype} (for CPU type: 0x#{"%08x" % cputype})"
    end
  end

  # Raised when a mach-o file's filetype field is unknown.
  class FiletypeError < MachOError
    # @param num [Fixnum] the unknown number
    def initialize(num)
      super "Unrecognized Mach-O filetype code: 0x#{"%02x" % num}"
    end
  end

  # Raised when an unknown load command is encountered.
  class LoadCommandError < MachOError
    # @param num [Fixnum] the unknown number
    def initialize(num)
      super "Unrecognized Mach-O load command: 0x#{"%02x" % num}"
    end
  end

  # Raised when a load command can't be created manually.
  class LoadCommandNotCreatableError < MachOError
    # @param cmd_sym [Symbol] the uncreatable load command's symbol
    def initialize(cmd_sym)
      super "Load commands of type #{cmd_sym} cannot be created manually"
    end
  end

  # Raised when the number of arguments used to create a load command manually is wrong.
  class LoadCommandCreationArityError < MachOError
    # @param cmd_sym [Symbol] the load command's symbol
    # @param expected_arity [Fixnum] the number of arguments expected
    # @param actual_arity [Fixnum] the number of arguments received
    def initialize(cmd_sym, expected_arity, actual_arity)
      super "Expected #{expected_arity} arguments for #{cmd_sym} creation, got #{actual_arity}"
    end
  end

  # Raised when a load command can't be serialized.
  class LoadCommandNotSerializableError < MachOError
    # @param cmd_sym [Symbol] the load command's symbol
    def initialize(cmd_sym)
      super "Load commands of type #{cmd_sym} cannot be serialized"
    end
  end

  # Raised when a load command string is malformed in some way.
  class LCStrMalformedError < MachOError
    # @param lc [MachO::LoadCommand] the load command containing the string
    def initialize(lc)
      super "Load command #{lc.type} at offset #{lc.view.offset} contains a malformed string"
    end
  end

  # Raised when a change at an offset is not valid.
  class OffsetInsertionError < MachOError
    # @param offset [Fixnum] the invalid offset
    def initialize(offset)
      super "Insertion at offset #{offset} is not valid"
    end
  end

  # Raised when load commands are too large to fit in the current file.
  class HeaderPadError < MachOError
    # @param filename [String] the filename
    def initialize(filename)
      super "Updated load commands do not fit in the header of " +
      "#{filename}. #{filename} needs to be relinked, possibly with " +
      "-headerpad or -headerpad_max_install_names"
    end
  end

  # Raised when attempting to change a dylib name that doesn't exist.
  class DylibUnknownError < MachOError
    # @param dylib [String] the unknown shared library name
    def initialize(dylib)
      super "No such dylib name: #{dylib}"
    end
  end

  # Raised when a dylib is missing an ID
  class DylibIdMissingError < MachOError
    def initialize
      super "Dylib is missing a dylib ID"
    end
  end

  # Raised when attempting to change an rpath that doesn't exist.
  class RpathUnknownError < MachOError
    # @param path [String] the unknown runtime path
    def initialize(path)
      super "No such runtime path: #{path}"
    end
  end

  # Raised when attempting to add an rpath that already exists.
  class RpathExistsError < MachOError
    # @param path [String] the extant path
    def initialize(path)
      super "#{path} already exists"
    end
  end

  # Raised whenever unfinished code is called.
  class UnimplementedError < MachOError
    # @param thing [String] the thing that is unimplemented
    def initialize(thing)
      super "Unimplemented: #{thing}"
    end
  end
end
