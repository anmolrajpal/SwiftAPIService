
import PackagePlugin
import Foundation

@main
struct GenerateHelpers: CommandPlugin {
   
   func performCommand(context: PluginContext, arguments: [String]) async throws {
      // Get the path for the generated file (consider user configuration)
      let generatedFilePath = getGeneratedFilePath(context: context)
      
      // Check if the file already exists (optional)
      if FileManager.default.fileExists(atPath: generatedFilePath) {
         print("Placeholder file already exists at: \(generatedFilePath)")
         return
      }
      
      // Generate the code using the template
      let generatedCode = generateCode()
      
      // Write the generated code to the external file
      writeCodeToFile(generatedCode: generatedCode, path: generatedFilePath)
      
      print("Placeholder code generated successfully at: \(generatedFilePath)")
   }
   
   // Function to get the path for the generated file (consider user configuration)
   private func getGeneratedFilePath(context: PluginContext) -> String {
      // Implement logic to determine the path based on project structure or user input
      // (e.g., within the project's "Generated" folder)
      return "\(context.pluginWorkDirectory)/SwiftAPI+Helpers/Endpoint.swift"
   }
   
   // Function to generate the code using the template
   private func generateCode() -> String {
      let templatePath = Bundle.main.path(forResource: "HelperFile.txt", ofType: nil)!
      let templateContent = try! String(contentsOfFile: templatePath)

      // You can customize the generation logic here (e.g., add package information)
      return templateContent
   }
   
   // Function to write the generated code to the external file
   private func writeCodeToFile(generatedCode: String, path: String) {
      FileManager.default.createFile(atPath: path, contents: generatedCode.data(using: .utf8)!)
   }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension GenerateHelpers: XcodeCommandPlugin {
   func performCommand(context: XcodeProjectPlugin.XcodePluginContext, arguments: [String]) throws {
      // Get the path for the generated file (consider user configuration)
      let generatedFilePath = getGeneratedFilePath(context: context)
      
      // Check if the file already exists (optional)
      if FileManager.default.fileExists(atPath: generatedFilePath) {
         print("Placeholder file already exists at: \(generatedFilePath)")
         return
      }
      
      // Generate the code using the template
      let generatedCode = generateCode()
      
      // Write the generated code to the external file
      writeCodeToFile(generatedCode: generatedCode, path: generatedFilePath)
      
      print("Placeholder code generated successfully at: \(generatedFilePath)")
   }
   
   private func getGeneratedFilePath(context: XcodeProjectPlugin.XcodePluginContext) -> String {
      // Implement logic to determine the path based on project structure or user input
      // (e.g., within the project's "Generated" folder)
      return "\(context.pluginWorkDirectory)/SwiftAPI+Helpers/Endpoint.swift"
   }
}
#endif
