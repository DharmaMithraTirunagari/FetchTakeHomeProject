//
//  FetchTakeHomeProjectTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import XCTest
@testable import FetchTakeHomeProject

@MainActor
final class Fetch_RecipeProjectTests: XCTestCase {
    
    var mockService: MockApiService!
    var viewModel: RecipeViewModel!
    
    override func setUp() {
        super.setUp()
        mockService = MockApiService()
        viewModel = RecipeViewModel(networkManager: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Test Successful Fetch
    func testViewModelFetchDataSuccess() async {
        // Arrange
        mockService.shouldFail = false
        mockService.shouldReturnEmpty = false
        mockService.shouldReturnMalformed = false

        // Act
        viewModel.fetchData()

        // Wait for the task to complete
        await Task.sleep(500_000_000) // 0.5 seconds

        // Assert
        XCTAssertEqual(viewModel.recipes.count, 2, "There should be exactly 2 mock recipes.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on a successful fetch.")
    }
    
    // MARK: - Test Fetch Failure
    func testViewModelFetchDataFailure() async {
        // Arrange
        mockService.shouldFail = true

        // Act
        viewModel.fetchData()

        // Wait for the task to complete
        await Task.sleep(500_000_000)

        // Assert
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when fetch fails.")

    }
    
    // MARK: - Test Empty State
    func testViewModelFetchEmptyState() async {
        // Arrange
        mockService.shouldReturnEmpty = true

        // Act
        viewModel.fetchData()

        // Wait for the task to complete
        await Task.sleep(500_000_000)

        // Assert
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when the API returns no data.")
        XCTAssertEqual(viewModel.errorMessage, "No recipes available.", "Error message should indicate no recipes are available.")
    }
    
    // MARK: - Test Malformed Data
    func testViewModelFetchMalformedData() async {
        // Arrange
        mockService.shouldReturnMalformed = true

        // Act
        viewModel.fetchData()

        // Wait for the task to complete
        await Task.sleep(500_000_000)

        // Assert
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when the API returns malformed data.")

    }
    
    // MARK: - Test Image Fetching Success
    func testImageFetchingSuccess() async throws {
        // Arrange
        mockService.mockImage = UIImage(systemName: "photo")

        // Act
        let fetchedImage = try await viewModel.fetchImage(url: "https://example.com/image.jpg")

        // Assert
        XCTAssertNotNil(fetchedImage, "Fetched image should not be nil.")
    }
    
    // MARK: - Test Image Fetching Failure
    func testImageFetchingFailure() async {
        // Arrange
        mockService.mockImage = nil

        // Act
        let fetchedImage = await viewModel.fetchImage(url: "https://example.com/image.jpg")

        // Assert
        XCTAssertNil(fetchedImage, "Fetched image should be nil when fetching fails.")
    }
}




