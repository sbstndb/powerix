#pragma once

#include <cmath>
#include <utility>

namespace powerix {

struct Error {
    double abs_err;
    double rel_err;
};

// Calcule l'erreur absolue et relative entre une valeur de référence et une valeur test
inline Error compute_error(double reference, double value) {
    Error e;
    e.abs_err = std::abs(reference - value);
    e.rel_err = reference != 0.0 ? e.abs_err / std::abs(reference) : 0.0;
    return e;
}

} // namespace powerix 