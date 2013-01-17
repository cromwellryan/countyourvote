# https://github.com/guard/guard#readme
guard 'jasmine-node', :jasmine_node_bin => File.expand_path(File.dirname(__FILE__) + "/node_modules/jasmine-node/bin/jasmine-node"), :spec_paths => ['specs'] do
# standard run the spec that changes
  watch(%r{^specs/(.+)_spec\.(js\.coffee|js|coffee)}) 

# run the spec for the file that changed... then all
  watch(%r{^(?!specs)(.+)\.(js\.coffee|js|coffee)})  { |m| "specs/#{m[1]}_spec.#{m[2]}" if File.exist?("specs/#{m[1]}_spec.#{m[2]}") }
end
