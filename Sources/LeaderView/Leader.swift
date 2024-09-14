//
//  Leader.swift
//  LeaderView
//
//  Created by Joshua Nozzi on 8/11/24.

import SwiftUI

private let LeaderPriority: Double = -900
private let DefaultLeadingViewPriority: Double = 800
private let DefaultTrailingViewPriority: Double = 1000
private let DefaultDotDiameter: Double = 3
private let DefaultDotSpacing: Double = 8
private let DefaultViewSpacing: Double = 10
private let DefaultLeaderColor: Color = .secondary
private let DefaultMinLeaderWidth: Double = 10

/// A typographical leader (dotted line at last baseline) to lead the eye from the leading view to the trailing view (usually but not limited to text).
struct Leader<LeadingView: View, TrailingView: View>: View {
  
  /// The leading view (such as a chapter title)
  @ViewBuilder let leadingView: () -> LeadingView

  /// The trailing view (such as the chapter's page number)
  @ViewBuilder let trailingView: () -> TrailingView
  
  /// The vertical alignment of the leading/trailing/leader views.
  /// Default is .lastTextBaseline
  var alignment: VerticalAlignment
  
  /// The layout priority of the leading view.
  /// Default is 800
  var leadingPriority: Double

  /// The layout priority of the trailing view.
  /// Default is 1000
  var trailingPriority: Double

  /// The diameter of the leader dots.
  /// Default is 3
  var dotDiameter: Double

  /// The color of the leader dots.
  /// Default is Color.secondary
  var leaderColor: Color

  /// The spacing between leading view, trailing view, and leader.
  /// Default is 10
  var viewSpacing: Double

  /// The spacing between the leader dots.
  /// Default is 8
  var dotSpacing: Double

  // The minimum width allowed for the leader dots.
  // Default is 10
  var minLeaderWidth: Double

  init(
    alignment: VerticalAlignment = .lastTextBaseline,
    leadingPriority: Double = DefaultLeadingViewPriority,
    trailingPriority: Double = DefaultTrailingViewPriority,
    dotDiameter: Double = DefaultDotDiameter,
    leaderColor: Color = DefaultLeaderColor,
    viewSpacing: Double = DefaultViewSpacing,
    dotSpacing: Double = DefaultDotSpacing,
    minLeaderWidth: Double = DefaultMinLeaderWidth,
    leadingView: @escaping () -> LeadingView,
    trailingView: @escaping () -> TrailingView
  ) {
    self.leadingView = leadingView
    self.trailingView = trailingView
    self.alignment = alignment
    self.leadingPriority = leadingPriority
    self.trailingPriority = trailingPriority
    self.dotDiameter = dotDiameter
    self.leaderColor = leaderColor
    self.viewSpacing = viewSpacing
    self.dotSpacing = dotSpacing
    self.minLeaderWidth = minLeaderWidth
  }

  var body: some View {

    // It's all contained in an HStack whose alignment and spacing is configurable
    HStack(
      alignment: alignment,
      spacing: viewSpacing
    ) {

      // We'll render the leading view first with the given priority
      leadingView()
        .layoutPriority(leadingPriority)

      // Now the leader dots...
      // (we need to know the available space)
      GeometryReader { g in

        // Some basic metrics
        let dotSpaceWidth = dotDiameter + dotSpacing
        let availableDotWidth: Double = g.size.width / dotSpaceWidth

        // Don't bother if there's no room
        if availableDotWidth >= 2 {

          // We skip the first dot for appearances
          ForEach(1..<Int(availableDotWidth), id: \.self)
          { x in

            // Draw an ellipse path of the given
            // diameter and fill with leaderColor
            Path { path in

              let r = CGRect(
                x: (Double(x) * dotSpaceWidth),
                y: 0,
                width: dotDiameter,
                height: dotDiameter)
              path.addEllipse(in: r)

            }
            .fill(leaderColor)

          }

        }

      }
      .frame(height: dotDiameter)
      .frame(minWidth: 0)
      .layoutPriority(LeaderPriority)
      .alignmentGuide(alignment) { $0[alignment] }

      // Finally, render the trailing view with the given priority
      trailingView()
        .layoutPriority(trailingPriority)

    }

  }

}

// MARK: - Preview

#Preview {

  @Previewable @State var dotDiameter: Double = DefaultDotDiameter
  @Previewable @State var dotSpacing: Double = DefaultDotSpacing
  @Previewable @State var viewSpacing: Double = DefaultViewSpacing
  @Previewable @State var minLeaderWidth: Double = DefaultMinLeaderWidth

  VStack(alignment: .leading) {

    Text("Contents")
      .font(.title)

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Foreword")
        .font(.title2)
    } trailingView: {
      Text("i")
        .font(.title3)
        .monospaced()
        .italic()
    }

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Introduction")
        .font(.title2)
    } trailingView: {
      Text("ii")
        .font(.title3)
        .monospaced()
        .italic()
    }

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Chapter 1: Typography 101")
        .font(.title2)
    } trailingView: {
      Text("100")
        .font(.title3)
        .monospacedDigit()
    }

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Chapter 2: Eye Leadership")
        .font(.title2)
    } trailingView: {
      Text("1000")
        .font(.title3)
        .monospacedDigit()
    }

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Chapter 3: The Power of Numbers")
        .font(.title2)
    } trailingView: {
      Text("15000")
        .font(.title3)
        .monospacedDigit()
    }

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Glossary")
        .font(.title2)
    } trailingView: {
      Text("100000")
        .font(.title3)
        .monospacedDigit()
    }

    Leader(
      dotDiameter: dotDiameter,
      viewSpacing: viewSpacing,
      dotSpacing: dotSpacing,
      minLeaderWidth: minLeaderWidth
    ) {
      Text("Index")
        .font(.title2)
    } trailingView: {
      Text("105000")
        .font(.title3)
        .monospacedDigit()
    }

  }
  .padding()

  Spacer()

  List {

    Text("Dot Diameter: \($dotDiameter.wrappedValue)")
    Slider(value: $dotDiameter, in: 1...10)

    Text("Dot Spacing: \($dotSpacing.wrappedValue)")
    Slider(value: $dotSpacing, in: 0...20)

    Text("View Spacing: \($viewSpacing.wrappedValue)")
    Slider(value: $viewSpacing, in: 0...50)

    Text("Min Leader Width: \($minLeaderWidth.wrappedValue)")
    Slider(value: $minLeaderWidth, in: 0...50)

  }
  .listStyle(InsetGroupedListStyle())

}
