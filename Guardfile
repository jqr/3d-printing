require "shellwords"

# Prints command before running it. Exception on non-zero exit status.
def nice_system(*cmd)
  joined_cmd = Shellwords.join(cmd)
  puts joined_cmd
  system(joined_cmd) || raise("ERORR!")
end

# Renders a filename using multiple output formats by changing the extension.
def render(filename, formats:)
  basename = File.basename(filename, ".scad")
  outputs = Array(formats).flat_map do |format|
    new_filename = basename + "." + format
    ["-o", new_filename]
  end
  nice_system("openscad", filename, "--enable", "manifold", "--hardwarnings", *outputs)
end

guard :shell do
  watch(/\.scad\z/) do |f|
    render(f[0], formats: %w(png stl 3mf))
  end
end
