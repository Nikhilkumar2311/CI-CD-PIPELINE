console.log("Running CI test....");

// simulating a test
const expected = 2 + 2;
const actual = 4;

if (expected !== actual){
  console.error("Test failed");
  process.exit(1);
}

console.log("All test passed");
process.exit(0);
