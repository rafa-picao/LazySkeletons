#include "../Framework/lskel.cuh"
#include <iostream>

struct Saxpy{
    float a;
    Saxpy(float a_) : a(a_) {}

    template<typename T1, typename T2>
    __host__ __device__ float operator()(const T1& x, const T2& y) const {
        return a * x + y;
    }
};

int main() {
    const size_t N = 1 << 20;
    const float a = 2.0f;

    lskel::Vector<float> x(N);
    lskel::Vector<float> y(N);

    // Initialize x and y with a sequence of values
    x.fill_with_sequence(); // Fills x with 1.0, 2.0, 3.0, ...
    y.fill_with_sequence(); // Fills y with 1.0, 2.0, 3.0, ...

    // Perform SAXPY operation: y = a * x + y

    y = y.map(x, Saxpy(a));

    // Verify the result
    bool correct = true;
    for (size_t i = 0; i < N; ++i) {
        float expected = a * (i + 1.0f) + (i + 1.0f);
        if (fabs(y[i] - expected) > 1e-5) {
            correct = false;
            std::cout << "Error at index " << i << ": expected " << expected << ", got " << y[i] << std::endl;
            break;
        }
    }

    if (correct) {
        std::cout << "SAXPY operation completed successfully." << std::endl;
    }

    return 0;
}
