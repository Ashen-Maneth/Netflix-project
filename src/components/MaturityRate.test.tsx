import { render, screen } from "@testing-library/react";
import MaturityRate from "./MaturityRate";

describe("MaturityRate", () => {
  test("renders children content", () => {
    render(<MaturityRate>TV-MA</MaturityRate>);
    expect(screen.getByText("TV-MA")).toBeInTheDocument();
  });

  test("renders a wrapper element", () => {
    const { container } = render(<MaturityRate>R</MaturityRate>);
    expect(container.firstChild?.nodeName).toBe("DIV");
  });
});
