namespace RQLRandomNumber {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    @EntryPoint()
    operation Main() : Int {
        let min = 0;
        let max = 10000000;
        Message($"Your random number between {min} and {max} is: ");

        // Generate random number in the 0..max range.
        return GenerateRandomNumberInRange(min, max);
    }

    /// Generates a random number between `min` and `max`.
    operation GenerateRandomNumberInRange(min : Int, max : Int) : Int {
        mutable bits = [];
        let range = max - min + 1;
        let nBits = BitSizeI(range);
        for idxBit in 1..nBits {
            set bits += [GenerateRandomBit()];
        }
        let sample = ResultArrayAsInt(bits) + min;

        // If the sample is within the range, return it; otherwise, try again.
        if (sample >= min and sample <= max) {
            return sample;
        }
        else {
            return GenerateRandomNumberInRange(min, max);
        }
    }

    operation GenerateRandomBit() : Result {
        // First lets allocate our single qubit
        use q = Qubit();

        // Next set this qubit into a superposition state using Hadarmard GenerateRandomNumber

        H(q);
        
        // At this point the qubit `q` has 50% chance of being measured in the
        // |0〉 state and 50% chance of being measured in the |1〉 state.
        
        // Measure the qubit value using the `M` operation, and store the
        let result = M(q);

        // Always reset qubit to the |0〉 state.
        // Qubits must be in the |0〉 state by the time they are released.
        Reset(q);
        
        // Return the result of the measurement.
        return result;

    }


}