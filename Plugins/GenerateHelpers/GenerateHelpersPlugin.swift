
import PackagePlugin
import Foundation

@main
struct GenerateHelpersPlugin: CommandPlugin {
   
   func performCommand(context: PluginContext, arguments: [String]) async throws {
      let tool = try context.tool(named: "generate-helpers")
      let toolUrl = URL(fileURLWithPath: tool.path.string)
      
      let process = Process()
      process.executableURL = toolUrl
      
      try process.run()
      process.waitUntilExit()
      
      if process.terminationStatus == 0 {
         print("Endpoint.swift has been generated and added to the Xcode project.")
      } else {
         print("Failed to generate Endpoint.swift.")
      }
      /*
      do {
         try trigger(context: context)
      } catch {
         fatalError("Failed: \(error.localizedDescription)")
      }
      
      // Execute the shell script to add the file to the Xcode project
      // Locate the script path
      let scriptPath = Bundle.main.path(forResource: "add_endpoint_to_xcode", ofType: "sh")!

      // Execute the shell script to add the file to the Xcode project
      let process = Process()
      process.executableURL = URL(fileURLWithPath: "/bin/bash")
      process.arguments = [scriptPath]

      do {
          try process.run()
          process.waitUntilExit()

          if process.terminationStatus == 0 {
              print("Endpoint.swift has been added to the Xcode project.")
          } else {
              fatalError("Failed to add Endpoint.swift to the Xcode project.")
          }
      } catch {
          fatalError("Failed to run the script: \(error)")
          
      }
      */
      // Get the path for the generated file (consider user configuration)
//      let generatedFilePath = getGeneratedFilePath(context: context)
//      
//      // Check if the file already exists (optional)
//      if FileManager.default.fileExists(atPath: generatedFilePath) {
//         print("Placeholder file already exists at: \(generatedFilePath)")
//         return
//      }
//      
//      // Generate the code using the template
//      let generatedCode = generateCode()
//      
//      // Write the generated code to the external file
//      writeCodeToFile(generatedCode: generatedCode, path: generatedFilePath)
//      
//      print("Placeholder code generated successfully at: \(generatedFilePath)")
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
   
   func trigger(context: PluginContext) throws {
      let fileManager = FileManager.default
//      let currentDirectoryPath = fileManager.currentDirectoryPath
      let currentDirectoryPath = context.pluginWorkDirectory
      let filePath = "\(currentDirectoryPath)/Endpoint.swift"
      
      let content = """
              // Generated by GenerateEndpointPlugin
              import Foundation
              
              enum Endpoint {
                  case example
                  case anotherExample
              }
              """
      
      // Check if the file already exists
      if fileManager.fileExists(atPath: filePath) {
         print("Endpoint.swift already exists.")
      } else {
         // Create the Endpoint.swift file
         do {
                 try content.write(toFile: filePath, atomically: true, encoding: .utf8)
                 print("Endpoint.swift has been generated at \(filePath).")
             } catch {
                 fatalError("Failed to write Endpoint.swift: \(error)")
             }
      }
   }
   
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension GenerateHelpersPlugin: XcodeCommandPlugin {
   func performCommand(context: XcodeProjectPlugin.XcodePluginContext, arguments: [String]) throws {
      let tool = try context.tool(named: "generate-helpers")
      let toolUrl = URL(fileURLWithPath: tool.path.string)
      
      let process = Process()
      process.executableURL = toolUrl
      
      try process.run()
      process.waitUntilExit()
      
      if process.terminationStatus == 0 {
         print("Endpoint.swift has been generated and added to the Xcode project.")
      } else {
         print("Failed to generate Endpoint.swift.")
      }
      
      // Get the path for the generated file (consider user configuration)
      /*
      do {
         try triggerXcode(context: context)
      } catch {
         fatalError("Failed Xcode: \(error.localizedDescription)")
      }
      */
   }
   
   private func getGeneratedFilePath(context: XcodeProjectPlugin.XcodePluginContext) -> String {
      // Implement logic to determine the path based on project structure or user input
      // (e.g., within the project's "Generated" folder)
      return "\(context.pluginWorkDirectory)/Endpoint.swift"
   }
   
   func triggerXcode(context: XcodeProjectPlugin.XcodePluginContext) throws {
      let fileManager = FileManager.default
      let currentDirectoryPath = context.xcodeProject.targets
      let filePath = "\(currentDirectoryPath)/Endpoint.swift"
      
      let content = """
              // Generated by GenerateEndpointPlugin
              import Foundation
              
              enum Endpoint {
                  case example
                  case anotherExample
              }
              """
      
      // Check if the file already exists
      if fileManager.fileExists(atPath: filePath) {
         print("Endpoint.swift already exists.")
      } else {
         // Create the Endpoint.swift file
         try content.write(toFile: filePath, atomically: true, encoding: .utf8)
         print("Endpoint.swift has been generated.")
      }
      
      // Execute the shell script to add the file to the Xcode project
      let scriptPath = context.pluginWorkDirectory.appending("Scripts/add_endpoint_to_xcode.sh").string
      
      let process = Process()
      process.executableURL = URL(fileURLWithPath: "/bin/bash")
      process.arguments = [scriptPath]
      
      try process.run()
      process.waitUntilExit()
      
      if process.terminationStatus == 0 {
         print("Endpoint.swift has been added to the Xcode.")
      } else {
         fatalError("Failed to add Endpoint.swift to the Xcode project.")
      }
   }
}
#endif

