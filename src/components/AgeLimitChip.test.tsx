import { render, screen } from "@testing-library/react";
import AgeLimitChip from "./AgeLimitChip";

describe("AgeLimitChip", () => {
  test("renders label text", () => {
    render(<AgeLimitChip label="18+" />);
    expect(screen.getByText("18+")).toBeInTheDocument();
  });

  test("uses outlined chip variant", () => {
    render(<AgeLimitChip label="PG-13" data-testid="age-chip" />);
    expect(screen.getByTestId("age-chip")).toHaveClass("MuiChip-outlined");
  });
});
