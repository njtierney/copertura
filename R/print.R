#' @export
print.maxcovr_relocation <- function(x, ...){

    user_input <- c(
        paste(x$model_call[[1]]),
        x$solver_used[[1]]
    )

    model_input <- c("model_used",names(formals(max_coverage_relocation)))

    cat("\n-----------------------------------------" ,
        "\nModel Fit: maxcovr relocation model",
        "\n-----------------------------------------",
        # I tried, I really did, to use purrr. "
        # purrr::map2(model_input, user_input,
        #             +              sprintf("%s: %s"))
        # Error in sprintf("%s: %s") : too few arguments
        sprintf("\n%s:        %s", model_input[[1]], user_input[[1]]),
        sprintf("\n%s: %s", model_input[[2]], user_input[[2]]),
        sprintf("\n%s: %s", model_input[[3]], user_input[[3]]),
        sprintf("\n%s:              %s", model_input[[4]], user_input[[4]]),
        sprintf("\n%s:   %s", model_input[[5]], user_input[[5]]),
        sprintf("\n%s:      %s", model_input[[6]], user_input[[6]]),
        sprintf("\n%s:     %s", model_input[[7]], user_input[[7]]),
        sprintf("\n%s:        %s", model_input[[8]], user_input[[8]]),
        sprintf("\n%s:            %s", model_input[[9]], user_input[[9]]),
        "\n-----------------------------------------\n"
    )

}

#' @export
summary.maxcovr_relocation <- function(object, ...){

    cat("\n---------------------------------------",
        "\nModel Fit: maxcovr relocation model",
        "\n---------------------------------------",
        sprintf("\nDistance Cutoff: %sm",
                object$model_coverage[[1]]$distance_within),
        "\nFacilities:",
        "\n    Added:      ",
        paste(deparse(object$model_coverage[[1]]$n_proposed_chosen)),
        "\n    Removed:    ",
        paste(deparse(object$model_coverage[[1]]$n_existing_removed)),
        "\nCoverage (Previous):",
        "\n    # Users: ",
        sprintf("   %s   (%s)",
                object$model_coverage[[1]]$n_cov,
                object$existing_coverage[[1]]$n_cov),
        "\n    Proportion: ",
        sprintf("%s (%s)",
                round(object$model_coverage[[1]]$pct_cov,4),
                round(object$existing_coverage[[1]]$pct_cov,4)
        ),
        "\nDistance (m) to Facility (Previous):",
        sprintf("\n       Avg:      %s (%s)",
                round(object$model_coverage[[1]]$dist_avg,0),
                round(object$existing_coverage[[1]]$dist_avg,0)),
        sprintf("\n       SD:       %s (%s)",
                round(object$model_coverage[[1]]$dist_sd,0),
                round(object$existing_coverage[[1]]$dist_sd,0)),
        "\nCosts:",
        "\n    Total:      ",
        paste(deparse(object$model_coverage[[1]]$total_cost)),
        "\n    Install:    ",
        paste(deparse(object$model_coverage[[1]]$install_cost)),
        "\n    Removal: ",
        paste(deparse(object$model_coverage[[1]]$cost_removal)),
        "\n---------------------------------------\n"
    )

}

#' @export
print.maxcovr <- function(x, ...){

    user_input <- c(paste(x$model_call[[1]]),
                    "lpSolve")

    model_input <- c("model_used",names(formals(max_coverage)))

    cat("\n-------------------------------------------" ,
        "\nModel Fit: maxcovr fixed location model",
        "\n-------------------------------------------",
        sprintf("\n%s:        %s", model_input[[1]], user_input[[1]]),
        sprintf("\n%s: %s", model_input[[2]], user_input[[2]]),
        sprintf("\n%s: %s", model_input[[3]], user_input[[3]]),
        sprintf("\n%s:              %s", model_input[[4]], user_input[[4]]),
        sprintf("\n%s:   %s", model_input[[5]], user_input[[5]]),
        sprintf("\n%s:           %s", model_input[[6]], user_input[[6]]),
        sprintf("\n%s:            %s", model_input[[7]], user_input[[7]]),
        "\n-------------------------------------------\n"
    )

}

#' @export
summary.maxcovr <- function(object, ...){

    cat("\n-------------------------------------------" ,
        "\nModel Fit: maxcovr fixed location model",
        "\n-------------------------------------------",
        sprintf("\nDistance Cutoff: %sm",
                object$model_coverage[[1]]$distance_within),
        "\nFacilities:",
        "\n    Added:      ",
        paste(deparse(object$model_coverage[[1]]$n_added)),
        "\nCoverage (Previous):",
        "\n    # Users:    ",
        sprintf("%s    (%s)",
                object$model_coverage[[1]]$n_cov,
                object$existing_coverage[[1]]$n_cov),
        "\n    Proportion: ",
        sprintf("%s (%s)",
                round(object$model_coverage[[1]]$pct_cov,4),
                round(object$existing_coverage[[1]]$pct_cov,4)
        ),
        "\nDistance (m) to Facility (Previous):",
        sprintf("\n    Avg:         %s (%s)",
                round(object$model_coverage[[1]]$dist_avg,0),
                round(object$existing_coverage[[1]]$dist_avg,0)),
        sprintf("\n    SD:          %s (%s)",
                round(object$model_coverage[[1]]$dist_sd,0),
                round(object$existing_coverage[[1]]$dist_sd,0)),
        "\n-------------------------------------------\n"
    )

}
