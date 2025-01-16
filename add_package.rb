require 'xcodeproj'

if ARGV.length < 3
    puts "You need to provide at least 3 arguments, pod target name <target_name>, spm url <package_url>, spm tag <package_version>"
  end

target_name = ARGV[0]
package_url = ARGV[1]
package_version = ARGV[2]

project_path = 'Pods/Pods.xcodeproj'
# package_url = 'https://github.com/nuance-communications/Dragon-Medical-SpeechKit-iOS.git'
# package_version = '6.1.17'
# target_name = 'MySDKNewLib'

project = Xcodeproj::Project.open(project_path)
target = project.targets.find { |t| t.name == target_name }

if target
    # Add the Swift Package dependency
    package_reference = project.new(Xcodeproj::Project::Object::XCRemoteSwiftPackageReference)
    package_reference.repositoryURL = package_url
    package_reference.requirement = {
        'kind' => 'upToNextMajorVersion',
        'minimumVersion' => package_version
    }
    
    project.root_object.package_references << package_reference
    
    # Link the package to the target
    package_product_dependency = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
    package_product_dependency.package = package_reference
    package_product_dependency.product_name = 'Dragon-Medical-SpeechKit-iOS'
    
    target.package_product_dependencies << package_product_dependency
    
    project.save
    puts "Successfully added and linked the Swift Package to target #{target_name}."
else
    puts "Target #{target_name} not found."
end
