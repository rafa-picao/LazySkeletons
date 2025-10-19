#include "../Framework/lskel.cuh"
#include <iostream>

//vector norm functor
struct Square
{
    template<typename T>
    __host__ __device__ T operator()(const T& x) const {
        return x * x;
    }
};

struct Plus
{
    template<typename T>
    __host__ __device__ T operator()(const T& a, const T& b) const {
        return a + b;
    }
};

int main() {
    const size_t N = 1 << 20;

    lskel::Vector<float> x(N);

    // Initialize x with a sequence of values
    x.fill_with_sequence(); // Fills x with 1.0, 2.0, 3.0, ...

    // Compute the norm of the vector
    float sum_of_squares = x.map(Square()).reduce(Plus(), 0.0f);

    float norm = std::sqrt(sum_of_squares);

    x = x / norm;

    // Print the first 10 elements of the normalized vector
    std::cout << "First 10 elements of the normalized vector:\n";
    for (size_t i = 0; i < 10; ++i) {
        std::cout << x[i] << " ";
    }
    
    //Expected
    std::cout << "\nExpected:\n";
    for (size_t i = 1; i <= 10; ++i) {
        std::cout << (i / norm) << " ";
    }

    return 0;
}
