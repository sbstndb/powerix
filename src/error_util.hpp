#pragma once

#include <cmath>
#include <utility>

namespace powerix {

// Error structure for absolute and relative error
struct Error {
    double abs_err;  // Absolute error
    double rel_err;  // Relative error
};

// Compute absolute and relative error between reference and value
inline Error compute_error(double reference, double value) {
    double abs_err = std::abs(reference - value);
    double rel_err = (reference != 0.0) ? abs_err / std::abs(reference) : 0.0;
    return {abs_err, rel_err};
}

} // namespace powerix 