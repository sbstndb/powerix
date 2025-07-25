#pragma once

#include <cmath>
#include <unordered_map>
#include <tuple>
#include <mutex>
#include <type_traits>
#include <functional>

namespace powerix {

// 1. Wrapper autour de std::pow

template <typename Base, typename Exp>
inline auto pow_std(Base base, Exp exp) {
    return std::pow(base, exp);
}

// 2. Exponentiation rapide pour exposants entiers (exp >= 0)
// Fonction générique gérant bases flottantes ou entières

template <typename Base>
inline Base pow_fast_int(Base base, unsigned int exp) {
    Base result = static_cast<Base>(1);
    Base factor = base;
    unsigned int e = exp;
    while (e > 0) {
        if (e & 1u) {
            result *= factor;
        }
        factor *= factor;
        e >>= 1u;
    }
    return result;
}

// 3. Version mémoïsée pour appels répétés avec mêmes arguments
// Clé = tuple<base, exp> ; on suppose base et exp convertibles en double et int pour la clé.
// On fournit séparément pour (double,int) ; peut être étendu si nécessaire.

// Fonction de hash pour std::pair<double, int>
struct PairHash {
    template <class T1, class T2>
    std::size_t operator() (const std::pair<T1, T2>& p) const {
        auto h1 = std::hash<T1>{}(p.first);
        auto h2 = std::hash<T2>{}(p.second);
        return h1 ^ (h2 << 1);
    }
};

inline double pow_cached(double base, int exp) {
    using Key = std::pair<double, int>;
    // Cache local statique, protégé par mutex pour thread safety simple.
    static std::unordered_map<Key, double, PairHash> cache;
    static std::mutex mtx;

    Key k{base, exp};
    {
        std::scoped_lock lock(mtx);
        auto it = cache.find(k);
        if (it != cache.end()) {
            return it->second;
        }
    }
    // Pas trouvé, on calcule.
    double result;
    if (exp >= 0) {
        result = pow_fast_int(base, static_cast<unsigned int>(exp));
    } else {
        result = 1.0 / pow_fast_int(base, static_cast<unsigned int>(-exp));
    }

    {
        std::scoped_lock lock(mtx);
        cache.emplace(k, result);
    }
    return result;
}

// Helper pour generer des alias si besoin

} // namespace powerix 