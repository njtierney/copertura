# augmenters and model summary constructors.
# these functions exist to provide more transparent and re-useable
# functions to provide summaries for maxcovr.
# Soon, they will be implemented throughout maxcovr, but are being tested atm.

#' Nearest wrapper
#'
#' This function is wrapper to `nearest`, adding `is_covered` to the model. This
#'   function is explicit about inputs, and is useful in cross validation -
#'   evaluating how test data performs against suggested facilities in the
#'   training set. This might be added to `nearest`, and may become obsolete.
#'
#' @param all_facilities data.frame Facilities selected in maxcovr model
#' @param test_data data.frame test data (but it could be any `user`-type data)
#' @param distance_threshold numeric
#'
#' @return dataframe containing distances between each test data observation
#'   and the nearest facility.
#'
#' @examples
#'
#' \dontrun{
#'
#' mc_cv_relocate_n100_cut %>%
#'   mutate(user_nearest_test = map2(
#'     .x = facilities_selected,
#'     .y = test,
#'     .f = augment_user_tested
#'     ))
#'
#' }
#'
#' @export
#'
augment_user_tested <- function(all_facilities,
                                test_data,
                                distance_threshold = 100){

    nearest(nearest_df = all_facilities,
            to_df = test_data) %>%
        dplyr::mutate(is_covered = (distance <= distance_threshold))

}

#' Summarise the coverage for users
#'
#' This uses a `user` dataframe obtained from something like
#' `augment_user_tested`.
#'
#' @param user dataframe of users with distances between each user and the
#'   nearest facility (`distance`), and whether this is within the distance
#'   threshold (`is_covered`).
#'
#' @return dataframe containing information on the number of users, the number
#'   of events covered, the proportion of events covered, and the distance from
#'   each
#'
#' @examples
#'
#' \dontrun{
#'
#'summarise_user_cov(augmented_user_test)
#'
# augmented_user_test %>%
#   group_by(area) %>%
#   summarise_user_cov()
#'
#' }
#'
#' @export
#'
summarise_user_cov <- function(user){

    user %>%
        dplyr::summarise(n_users = n(),
                         n_cov = sum(is_covered),
                         pct_cov = mean(is_covered),
                         dist_avg = mean(distance),
                         dist_sd = sd(distance))

}

#' Find distance from relocated and proposed new sites
#'
#' This takes the proposed sites and the existing sites, with additional
#'   information from the model, and then returns a dataframe of all of the
#'   existing facilities that were relocated, and provides the distance to the
#'   nearest facility, which is presumably the location to which it was
#'   relocated to.
#'
#' @param proposed_facility facilities proposed for the model - but this data
#'   has extra information (`is_installed`) in it.
#' @param existing_facility facilities existing for the model - but this data
#'   has extra information (`is_relocated`) in it.
#'
#' @return dataframe
#'
#' @examples
#'
#' \dontrun{
#'
#' mc_cv_n100_test %>%
#'   mutate(facility_distances = map2(
#'     .x = proposed_facility,
#'     .y = existing_facility,
#'     .f = augment_facility_relocated)) %>%
#'   select(facility_distances) %>%
#'   .[[1]]
#'
#' }
#'
#' @export
#'
augment_facility_relocated <- function(proposed_facility,
                                       existing_facility){

    nearest(
        nearest_df = {dplyr::filter(proposed_facility,
                                    is_installed == 1)},
        to_df = {dplyr::filter(existing_facility,
                               is_relocated == 1)}
    )
}

# the little summaries of proposed facilities

#' Extract the number of facilities relocated.
#'
#' @param existing_facility the facilities originally existing, as output from
#'   the model (e.g., `model$existing_facility[[1]]`)
#'
#' @return dataframe containing one column of the number of things relocated
#'
#' @examples
#'
#' \dontrun{
#'
#' mc_cv_n100_test %>%
#'   mutate(n_relocated = map(
#'     .x = existing_facility,
#'     .f = n_relocated)) %>%
#'   select(n_relocated) %>%
#'   .[[1]]
#'
#' }
#'
#' @export
#'
n_relocated <- function(existing_facility){

    existing_facility %>%
        dplyr::summarise(n_relocated = sum(is_relocated))
}

#' Extract the number of facilities installed
#'
#' Using the model-modified dataframe of `proposed_facility`, count the
#'   number of events installed.
#'
#' @param proposed_facility dataframe from the mc_model, of facilities proposed
#'   with the additional information about whether the facility was installed
#'   or not - `is_installed`
#'
#' @return datafrmae
#'
#' @examples
#'
#' \dontrun{
#'
#' mc_cv_n100_test %>%
#'     mutate(n_installed = map(
#'         .x = proposed_facility,
#'         .f = n_installed
#'     )) %>%
#'     select(n_installed) %>%
#'     .[[1]]
#'
#' }
#'
#' @export
#'
n_installed <- function(proposed_facility){

    proposed_facility %>%
        dplyr::summarise(n_installed = sum(is_installed))

}


#' Find the average distance from facilities relocated to their final place
#'
#' This takes data from the function `augment_facility_relocated` function of
#'   the same name and then summarises it to find the average and sd of the
#'   distance between the two.
#'
#' @param augment_facility_relocated dataframe from function:
#'   `augment_facility_relocated`
#'
#' @return dataframe
#'
#' @examples
#'
#' \dontrun{
#'
#' mc_cv_n100_test %>%
#'     mutate(
#'         facility_distances = map2(
#'             .x = proposed_facility,
#'             .y = existing_facility,
#'             .f = augment_facility_relocated
#'         ),
#'         summary_relocated_dist = map(
#'             .x = facility_distances,
#'             .f = summarise_relocated_dist
#'         )
#'     ) %>%
#'     # select(facility_distances) %>%
#'     select(summary_relocated_dist) %>%
#'     .[[1]]
#'
#' }
#'
#' @export
#'
summarise_relocated_dist <- function(augment_facility_relocated){

    augment_facility_relocated %>%
        dplyr::summarise(dist_avg = mean(distance),
                         dist_sd = sd(distance))

}

