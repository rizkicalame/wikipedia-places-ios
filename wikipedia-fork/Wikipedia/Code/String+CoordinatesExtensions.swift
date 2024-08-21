
import Foundation

extension String {
    /// Converts the given string to an array containing exactly two Doubles in the format [latitude, longitude]
    /// Will return nil if conversion is not possible due to an incorrect format or the values are not convertable to Doubles.
    /// Key criteria are:
    /// - Digits only;
    /// - Comma separated;
    /// - Only two values are specified for latitude & longitude;
    /// E.g. 51.12345,10.12345 would translate to true.
    var getLatitudeLongitude: [Double]? {
        let latLong = self.components(separatedBy: ",")

        guard
            latLong.count == 2,
            let latitude = Double(latLong[0]),
            let longitude = Double(latLong[1]) else {
            return nil
        }

        return [latitude, longitude]
    }
}
