//
//  WeatherService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

final class WeatherService {
    
    private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"
    private let apiKey: String = "YOUR_API_KEY"
    private let session = URLSession.shared
    
    func fecthData(city: String, _ completion: @escaping (ForecastResponse?) -> Void) {
        let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(forecastResponse)
            } catch {
                print(error)
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getCoordinates(forCity city: String, completion: @escaping ((Double, Double)?) -> Void) {
        let cityName = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://nominatim.openstreetmap.org/search?format=json&q=\(cityName)"
        
        // Criar URL
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            completion(nil)
            return
        }
        
        // Criar e executar a requisição
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Erro ao obter dados:", error?.localizedDescription ?? "Erro desconhecido")
                completion(nil)
                return
            }
            
            // Decodificar a resposta JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                if let firstResult = json?.first,
                   let latString = firstResult["lat"] as? String,
                   let lonString = firstResult["lon"] as? String,
                   let latitude = Double(latString),
                   let longitude = Double(lonString) {
                    completion((latitude, longitude))
                } else {
                    print("Não foi possível encontrar as coordenadas para a cidade:", city)
                    completion(nil)
                }
            } catch {
                print("Erro ao decodificar resposta JSON:", error)
                completion(nil)
            }
        }
        task.resume()
    }
}

