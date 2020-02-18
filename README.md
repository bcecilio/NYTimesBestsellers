# NYTimesBestsellers
New York Times Bestseller books.


## Description: 

The New York Times best sellers app allows user's to look, favorite, and shop for their favorite collection of books from a list of highly curated best sellers list including fiction, non-fiction, travel, culture, education and others.




## Screenshot

## Code Snippet:

Generic API Client:

```swift
func getJSON<T: Decodable>(objectType: T.Type, with urlString: String, completionHandler: @escaping (Result<T, AppError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL(urlString)))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkHelper.shared.performDataTask(with: urlRequest, maxCacheDays: 3) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
```

Used one generic client so we didn't have to write numerous api clients that served the same purpose.


##  GIF

![](Assets/NYTimesBestsellersGif.gif)

## Collaborators: 
* https://github.com/bcecilio

* https://github.com/oscarvictoria

* https://github.com/ahadislam1

* https://github.com/IanKBailey


