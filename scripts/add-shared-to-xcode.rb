require 'xcodeproj'

# 打开 Xcode 项目
project = Xcodeproj::Project.open('../ios/dod.xcodeproj')

# 获取你想添加的 target
target = project.targets.first # 第一个 target

# 设置要添加的文件路径
file_path = '../shared'

# 将文件或文件夹添加到目标的资源列表中
file_ref = project.new_group("shared", file_path)
Dir.glob(File.join(file_path, '**', '*.{h,cpp}')).each do |file|
    native_file = file_ref.new_file(file)
    target.add_file_references([native_file]) if file.end_with?('.cpp')
end

# 保存项目文件
project.save
